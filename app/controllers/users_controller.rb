class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@orders = @user.orders
		@addresses = @user.addresses
	end
	def index
	end
end
