class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@orders = @user.orders
	end
	def index
	end
	def edit
		@user = User.find(params[:user_id])
		@earring = Earring.find(params[:earring_id])
		@action = params[:buyorsell]
		if @user.update(user_params)
			redirect_to "/earrings/#{@earring.id}/#{@action}/summary"
		else
			# flash[:notice] =
	  		redirect_to "/earrings/#{@earring.id}/#{@action}/users/#{@user.id}"
	  	end
	end

	private

	def user_params
		params.require(:user).permit(:street, :street2, :city, :state, :zip)
	end
end
