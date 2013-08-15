class OrdersController < ApplicationController

	def show
		@order = Order.find(params[:id])
	end

	def destroy
		@user = User.find(params[:user_id])
		@orders = @user.orders
		@order = @orders.find(params[:order_id])
		@order.destroy
		redirect_to user_path(@user)
	end

	private

	def order_params
			params.require(:order).permit(:user_id, :earring_id, :price_paid, :status)
	end
end
