class EarringsController < ApplicationController
	before_action :set_earring, only: [:show, :edit, :update, :destroy]

	def index
		@earrings = Earring.all
	end

	def show
		if current_user
			@user = current_user
		else
			@user = User.find(1)
		end
	end

	def new
		@earring = Earring.new
	end

	# GET /earrings/1/edit
	def edit
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
				format.html { redirect_to @earring, notice: 'Earring was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @earring.errors, status: :unprocessable_entity }
			end
		end
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

	private

	def set_earring
		@earring = Earring.find(params[:id])
	end

	def earring_params
			params.require(:earring).permit(:vendor, :collection, :design, :material, :size, :price, :sku, :inventory, :description, :image)
	end
end
