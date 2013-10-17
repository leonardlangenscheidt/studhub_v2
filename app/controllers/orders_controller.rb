class OrdersController < ApplicationController

	def show
		@order = Order.find(params[:order_id])
		@user = current_user
	end

	def destroy
		@user = current_user
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
