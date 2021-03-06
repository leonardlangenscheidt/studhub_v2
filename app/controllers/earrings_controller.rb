class EarringsController < ApplicationController
	before_action :set_earring, only: [:show, :update, :destroy, :restock, :pastorders]

	def index
		@earrings = Earring.all
		# @vendor = params[:v]
	end

	def inventory
		@vendor = params[:v]
		if current_user && current_user.admin == true
			@earrings = Earring.all
		else
			flash[:notice] = "Please don't mess around with our backend!"
			redirect_to earrings_path
		end
	end

	def show
		@detail = Detail.new
	end

	def new
		if current_user && current_user.admin == true
			@earring = Earring.new
		else
			flash[:notice] = "Please don't mess around with our backend!"
			redirect_to earrings_path
		end
	end

	# GET /earrings/1/edit
	def edit
		if current_user && current_user.admin == true
			@earring = Earring.find(params[:id])
		else
			flash[:notice] = "Please don't mess around with our backend!"
			redirect_to earrings_path
		end
	end

	# POST /earrings
	# POST /earrings.json
	def create
		@earring = Earring.new(earring_params)

		respond_to do |format|
			if @earring.save
				format.html { redirect_to '/inv/inventory', notice: 'Earring was successfully created.' }
				format.json { render action: 'index', status: :created, location: @earring }
			else
				format.html { render action: 'new' }
				format.json { render json: @earring.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /earrings/1
	# PATCH/PUT /earrings/1.json
	def update
		respond_to do |format|
			if @earring.update(earring_params)
				format.html { redirect_to '/inv/inventory', notice: 'Earring was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @earring.errors, status: :unprocessable_entity }
			end
		end
	end

	def pastorders
		if current_user && current_user.admin == true
			@orders = @earring.orders
		else
			flash[:notice] = "Please don't mess around with our backend!"
			redirect_to earrings_path
		end
	end

	# DELETE /earrings/1
	# DELETE /earrings/1.json
	def destroy
		@earring.destroy
		respond_to do |format|
			format.html { redirect_to '/inv/inventory' }
			format.json { head :no_content }
		end
	end

	def confirm
		if current_user
			@address = current_user.addresses.last
			@detail = @address.detail
			@earring = Earring.find(@detail.earring_id)
			@order = Order.new
		else
			redirect_to root_path
		end
	end

	private

	def set_earring
		@earring = Earring.find(params[:id])
	end

	def earring_params
		params.require(:earring).permit(:vendor, :collection, :design, :material, :size, :price, :sku, :inventory, :used_inventory, :description, :image, :sides, :easyRestock, :imageleft, :imageright)
	end
end
