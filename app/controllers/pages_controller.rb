class PagesController < ApplicationController
  	def home
	  	if current_user
	  		redirect_to earrings_path
	  	end
  	end

	def about
	end

  	def terms
  	end

  	def paypalorder
		@earring = Earring.find(params[:earring_id])
	  	@address = Address.find(params[:address_id])
	  	@buy = params[:buy]
		redirect_to user_orders_path(:earring_id =>@earring.id, :address_id =>@address.id, :buy => @buy), :method => :post
	end
end
