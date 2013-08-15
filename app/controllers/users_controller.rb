class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@orders = @user.orders
		unless @user.addresses == nil
			@addresses = @user.addresses
		end
	end
	def index
	end
end
