class ChargesController < ApplicationController
	def new
	end

	def create
	  	@earring = Earring.find(params[:earring_id])
	  	@amount =@earring.price
	  	@user = current_user

	  	customer = Stripe::Customer.create(
	    	:email => @user.email,
	    	:card  => params[:stripeToken]
	  	)

	  	charge = Stripe::Charge.create(
	    	:customer    => customer.id,
	    	:amount      => @amount,
	    	:description => 'Rails Stripe customer',
	    	:currency    => 'usd'
	  	)

		rescue Stripe::CardError => e
	  	flash[:error] = e.message
	  	redirect_to charges_path
	end
end
