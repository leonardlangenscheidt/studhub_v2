class OrdersController < ApplicationController

	def show
		@order = Order.find(params[:id])
		@user = current_user
	end

	def destroy
		@user = current_user
		@orders = @user.orders
		@order = @orders.find(params[:id])
		@order.destroy
		redirect_to user_path
	end

	private

	def order_params
			params.require(:order).permit(:user_id, :earring_id, :price_paid, :status)
	end
end
