class OrdersController < ApplicationController
	before_action :set_order, only: [:update, :ship, :arrival, :show, :destroy]

	def buy_index
		@orders = Order.all
	end

	def sell_index
		@orders = Order.all
	end

	def update
		unless @order.status == 'Shipped'
			@order.update(order_params)
			redirect_to '/orderpage/buy'
			UserMailer.shipping_email(@order).deliver
		else
			@order.update(order_params)
			redirect_to '/orderpage/buy'
		end
	end

	def arrival
		@order.status = "Received"
		@order.save
		redirect_to '/orderpage/sell'
		UserMailer.arrival_email(@order).deliver
	end

	def show
		@user = current_user
	end

	def destroy
		@user = current_user
		@orders = @user.orders
		@order.destroy
		redirect_to user_path
	end

	def new
	end

	def create
	  	@earring = Earring.find(params[:earring_id])
	  	@address = Address.find(params[:address_id])
	  	@buy = params[:buy]
	  	@user = current_user
		@order = Order.create(
		:user_id => @user.id,
		:earring_id => @earring.id,
		:price_paid => @earring.price,
		:address_id => @address.id,
		:buy => @buy
		)
		if @order.save
			if @order.buy == true
				@earring.inventory = @earring.inventory - 1
				@earring.save
				@order.status = "Confirmed"
				@order.save
				UserMailer.purchase_email(@order).deliver
		  		flash[:notice] = %Q[Thank you! You just purchased the #{@earring.material} #{@earring.design} earring from the #{@earring.vendor} #{@earring.collection} collection for $#{@amount}.00! <a href="#" onclick="
				window.open(
				  'http://www.facebook.com/sharer/sharer.php?s=100&p[url]=http://agile-peak-7882.herokuapp.com/&p[images][0]=&p[title]=Stud%20and%20Found&p[summary]=I%20just%20bought%20a%20match%20for%20the%20single%20earring%20I%20had%20left%20over.%20Woohoo!',
				  'facebook-share-dialog',
				  'width=626,height=436');
				return false;">Share on Facebook</a>].html_safe
			else
				@earring.inventory = @earring.inventory + 1
				@earring.save
				@order.status = "Awaiting Shipment"
				@order.save
				UserMailer.sell_email(@order).deliver
				flash[:notice] = %Q[Thank you! You just sold the #{@earring.material} #{@earring.design} earring from the #{@earring.vendor} #{@earring.collection} collection for $#{@earring.price}.00! <a href="#" onclick="
				window.open(
				  'http://www.facebook.com/sharer/sharer.php?s=100&p[url]=http://agile-peak-7882.herokuapp.com/&p[images][0]=&p[title]=Stud%20and%20Found&p[summary]=I%20just%20sold%20a%20single%20earring%20I%20had%20left%20over.%20Woohoo!',
				  'facebook-share-dialog',
				  'width=626,height=436');
				return false;">Share on Facebook</a>].html_safe
			end
			redirect_to "/user/orders/#{@order.id}"
		else
			flash[:notice] = "Something went wrong. Please try again."
			redirect_to "/earrings/#{@earring.id}"
		end
	end

	private

	def set_order
		@order = Order.find(params[:id])
	end

	def order_params
			params.require(:order).permit(:user_id, :earring_id, :price_paid, :status, :tracking)
	end
end
