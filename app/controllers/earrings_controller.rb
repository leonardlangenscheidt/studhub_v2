class EarringsController < ApplicationController
	before_action :set_earring, only: [:show, :update, :destroy, :restock, :confirm, :pastorders]

	def index
		@earrings = Earring.all
	end

	def inventory
		if current_user && (current_user.name = "Leonard Langenscheidt" || current_user.name = "Jennifer Liu")
			@earrings = Earring.all
		else
			flash[:notice] = "Please don't mess around with our backend!"
			redirect_to earrings_path
		end
	end

	def show
	end

	def new
		if current_user && (current_user.name = "Leonard Langenscheidt" || current_user.name = "Jennifer Liu")
			@earring = Earring.new
		else
			flash[:notice] = "Please don't mess around with our backend!"
			redirect_to earrings_path
		end
	end

	# GET /earrings/1/edit
	def edit
		if current_user && (current_user.name = "Leonard Langenscheidt" || current_user.name = "Jennifer Liu")
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
				format.html { redirect_to earrings_url, notice: 'Earring was successfully created.' }
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
	end

	# DELETE /earrings/1
	# DELETE /earrings/1.json
	def destroy
		@earring.destroy
		respond_to do |format|
			format.html { redirect_to earrings_url }
			format.json { head :no_content }
		end
	end

	def confirm
		@address = current_user.addresses.last
		@buy = @address.buy
		@right = @address.right
		@used = @address.used
	end

	private

	def set_earring
		@earring = Earring.find(params[:id])
	end

	def earring_params
		params.require(:earring).permit(:vendor, :collection, :design, :material, :size, :price, :sku, :inv/inventory, :used_inv/inventory, :description, :image, :sides, :easyRestock)
	end
end
