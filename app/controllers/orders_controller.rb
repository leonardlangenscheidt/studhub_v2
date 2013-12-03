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
		@user = @order.user
		if current_user
			if current_user == @user
				render "show"
			elsif (current_user.name == "Leonard Langenscheidt" || current_user.name == "Jennifer Liu")
				render "adminshow"
			else
				flash[:notice] = "Please don't mess around with our backend!"
				redirect_to root_path
			end
		end
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
		@earring = @order.earring
		@address = @order.address
		if @order.save
			if @order.address.id == 73
				if @earring.sides == true
					@earring.inventory = @earring.inventory + 1001*@order.number
				else
					@earring.inventory = @earring.inventory + 2*@order.number
				end
				@earring.save
				flash[:notice] = 'Receipt was successfully created.'
				redirect_to inv_receivables_path
			else
				if @earring.sides == true
					if @address.right == true
						@earring.used_inventory = @earring.used_inventory + @order.number
					else
						@earring.used_inventory = @earring.used_inventory + 1000*@order.number
					end
				else
					@earring.used_inventory = @earring.used_inventory + @order.number
				end
				@earring.save
				@address.order_id = @order.id
				@address.save
				UserMailer.sell_email(@order).deliver
				flash[:notice] = %Q[Thank you! You just sold the #{@earring.material} #{@earring.design} earring from the #{@earring.vendor} #{@earring.collection} collection for $#{@earring.price}.00! <a href="#" onclick="
				window.open(
				  'http://www.facebook.com/sharer/sharer.php?s=100&p[url]=http://studandfound.com/&p[images][0]=&p[title]=Stud%20and%20Found&p[summary]=I%20just%20sold%20a%20single%20earring%20I%20had%20left%20over.%20Woohoo!',
				  'facebook-share-dialog',
				  'width=626,height=436');
				return false;">Share on Facebook</a>].html_safe
				redirect_to "/user/orders/#{@order.id}"
			end
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
