class OrdersController < ApplicationController
	def new
	end

	def create
		@user = User.find(params[:user_id])
		@earring = Earring.find(17)
		order = Order.create(
			:user_id => @user.id,
			:earring_id => @earring.id,
			:price_paid => @earring.price,
			:status => "shipping"
			)

		if order
	  		flash[:notice] = "Thank you! You just purchased the #{@earring.material} #{@earring.design} earring from the #{@earring.vendor} #{@earring.collection} collection for $#{@earring.price}.00!"
	  		redirect_to user_path(@user)
	  	else
	  		flash[:notice] = "That did not work."
	  		redirect_to user_path(@user)
	  	end
	end

	private

	def order_params
			params.require(:order).permit(:user_id, :earring_id, :price_paid, :status)
	end
end
