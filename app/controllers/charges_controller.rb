class ChargesController < ApplicationController
	def new
	end

	def create
	  	@earring = Earring.find(params[:earring_id])
	  	@address = Address.find(params[:address_id])
	  	@amount =@earring.price
	  	if current_user
		  	@user = current_user
		else
		  	@user = User.find(1)
		end

	  	customer = Stripe::Customer.create(
	    	:email => 'user@example.com',
	    	:card  => params[:stripeToken]
	  	)

	  	charge = Stripe::Charge.create(
	    	:customer    => customer.id,
	    	:amount      => @amount,
	    	:description => 'Rails Stripe customer',
	    	:currency    => 'usd'
	  	)

	  	if charge
	  		order = Order.create(
			:user_id => @user.id,
			:earring_id => @earring.id,
			:price_paid => @earring.price,
			:status => "shipping",
			:address_id => @address.id
			)
			@earring.inventory = @earring.inventory - 1
			@earring.save
	  		flash[:notice] = %Q[Thank you! You just purchased the #{@earring.material} #{@earring.design} earring from the #{@earring.vendor} #{@earring.collection} collection for $#{@amount}.00! <a href="#" onclick="
			window.open(
			  'https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Fagile-peak-7882.herokuapp.com',
			  'facebook-share-dialog',
			  'width=626,height=436');
			return false;">Share on Facebook</a>].html_safe
	  		redirect_to profile_path(order)
	  	else
	  		flash[:notice] = Stripe::CardError.message
	  		redirect_to earring_path(@earring)
	  	end

		# rescue Stripe::CardError => e
	 #  	flash[:error] = e.message
	 #  	redirect_to charges_path
	end
end
