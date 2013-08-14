class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@orders = @user.orders
	end
	def index
	end
	def edit
		@user = current_user
		@earring = Earring.find(params[:earring_id])
	end
end
