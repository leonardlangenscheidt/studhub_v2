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
	end
end
