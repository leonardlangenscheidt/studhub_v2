class OrdersController < ApplicationController
	before_action :set_order, only: [:update, :ship, :arrival, :show, :destroy]

	def deliverables
		@orders = Order.all
	end

	def receivables
		@orders = Order.all
	end

	def update
		if @order.status == 'Confirmed'
			@order.update(order_params)
			redirect_to inv_deliverables_path
			UserMailer.shipping_email(@order).deliver
		elsif @order.status == 'Awaiting Shipment'
			@order.update(order_params)
			redirect_to inv_receivables_path
			UserMailer.arrival_email(@order).deliver
		else
			flash[:notice] = 'Not a valid update'
			redirect_to inv_path
		end
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
		@earring = Earring.find(params[:earring_id])
		@order = Order.new
	end

	def create
		@order = Order.new(order_params)
		@order.save
		flash[:notice] = 'Receipt was successfully created.'
		redirect_to inv_reveivables_path
	end

	def remotecreate
	  	@earring = Earring.find(params[:earring_id])
	  	@address = Address.find(params[:address_id])
	  	@user = current_user
	  	if @address.buy == true
	  		@status = "Confirmed"
	  	else
	  		@status = "Awaiting Shipment"
	  	end
		@order = Order.create(
		:user_id => @user.id,
		:earring_id => @earring.id,
		:price_paid => @earring.price,
		:address_id => @address.id,
		:tax => 0,
		:number => 1,
		:status => @status
		)
		if @order.save
			if @order.address.buy == true
				if @order.address.used == true
					@earring.used_inventory = @earring.used_inventory - 1
				else
					@earring.inventory = @earring.inventory - 1
				end
				@earring.save
				UserMailer.purchase_email(@order).deliver
		  		flash[:notice] = %Q[Thank you! You just purchased the #{@earring.material} #{@earring.design} earring from the #{@earring.vendor} #{@earring.collection} collection for $#{@earring.price}.00! <a href="#" onclick="
				window.open(
				  'http://www.facebook.com/sharer/sharer.php?s=100&p[url]=http://studandfound.com/&p[images][0]=&p[title]=Stud%20and%20Found&p[summary]=I%20just%20bought%20a%20match%20for%20the%20single%20earring%20I%20had%20left%20over.%20Woohoo!',
				  'facebook-share-dialog',
				  'width=626,height=436');
				return false;">Share on Facebook</a>].html_safe
			else
				@earring.used_inventory = @earring.used_inventory + 1
				@earring.save
				UserMailer.sell_email(@order).deliver
				flash[:notice] = %Q[Thank you! You just sold the #{@earring.material} #{@earring.design} earring from the #{@earring.vendor} #{@earring.collection} collection for $#{@earring.price}.00! <a href="#" onclick="
				window.open(
				  'http://www.facebook.com/sharer/sharer.php?s=100&p[url]=http://studandfound.com/&p[images][0]=&p[title]=Stud%20and%20Found&p[summary]=I%20just%20sold%20a%20single%20earring%20I%20had%20left%20over.%20Woohoo!',
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
			params.require(:order).permit(:user_id, :earring_id, :price_paid, :status, :tracking, :tax, :number, :address_id)
	end
end
