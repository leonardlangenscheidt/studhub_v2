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

	def new
	end

	def create
	  	@earring = Earring.find(params[:earring_id])
	  	@address = Address.find(params[:address_id])
	  	# @buy = params[:buy]
	  	@user = current_user
		@order = Order.create(
		:user_id => @user.id,
		:earring_id => @earring.id,
		:price_paid => @earring.price,
		:status => "shipping",
		:address_id => @address.id
		)
		if @order.save
			@earring.inventory = @earring.inventory - 1
			@earring.save
			UserMailer.purchase_email(@order).deliver
			flash[:notice] = %Q[Thank you! You just purchased the #{@earring.material} #{@earring.design} earring from the #{@earring.vendor} #{@earring.collection} collection for $#{@amount}.00! <a href="#" onclick="
			window.open(
			  'http://www.facebook.com/sharer/sharer.php?s=100&p[url]=http://agile-peak-7882.herokuapp.com/&p[images][0]=&p[title]=Stud%20and%20Found&p[summary]=I%20just%20bought%20a%20match%20for%20the%20single%20earring%20I%20had%20left%20over.%20Woohoo!',
			  'facebook-share-dialog',
			  'width=626,height=436');
			return false;">Share on Facebook</a>].html_safe
			redirect_to "/user/orders/#{@order.id}"
		else
			flash[:notice] = "Something went wrong. Please try again."
			redirect_to "/earrings/#{@earring.id}"
		end
	end

	private

	def order_params
			params.require(:order).permit(:user_id, :earring_id, :price_paid, :status)
	end
end
