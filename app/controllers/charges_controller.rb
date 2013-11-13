class ChargesController < ApplicationController
	def new
	end

	def create
	  	@earring = Earring.find(params[:earring_id])
	  	@address = Address.find(params[:address_id])
	  	@buy = params[:buy]
	  	@amount =@earring.price
	  	@user = current_user

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
	  		redirect_to "/remotecreate?earring_id=#{@earring.id}&address_id=#{@address.id}&buy=#{@buy}", :method => :post
	  	else
	  		flash[:notice] = Stripe::CardError.message
	  		redirect_to earring_path(@earring)
	  	end

		# rescue Stripe::CardError => e
	 #  	flash[:error] = e.message
	 #  	redirect_to charges_path
	end
end
