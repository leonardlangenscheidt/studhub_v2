class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
		@orders = @user.orders
	end

	def index
	end

	def edit
		@earring = Earring.find(params[:earring_id])
		@action = params[:buyorsell]
		# @user.update(@user.street = params[:street])
		# 	@user.street2 = params[:street2],
		# 	@user.city = params[:city],
		# 	@user.state = params[:state],
		# 	@user.zip = params[:zip]
		# 	)
		# if @user.update
		# 	redirect_to "/earrings/#{@earring.id}/#{@action}/summary"
		# else
		# 	# flash[:notice] =
	 #  		redirect_to "/earrings/#{@earring.id}/#{@action}/users/#{@user.id}"
	 #  	end
	end

	def update
	    	respond_to do |format|
		      	if @user.update(user_params)
			        	format.html { redirect_to @user, notice: 'User was successfully updated.' }
			        	format.json { head :no_content }
		      	else
			        	format.html { render action: 'edit' }
			        	format.json { render json: @user.errors, status: :unprocessable_entity }
		      	end
	    	end
  	end

	private

	def set_user
		@user = User.find(params[:user_id])
	end

	def user_params
		params.require(:user).permit(:street, :street2, :city, :state, :zip)
	end
end
