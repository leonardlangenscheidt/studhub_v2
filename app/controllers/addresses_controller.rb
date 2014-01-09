class AddressesController < ApplicationController

	# GET /addresses/new
	def new
		@detail = Detail.find(params[:d])
		@earring = Earring.find(@detail.earring_id)
		@lastaddress = current_user.addresses.last
		@address = Address.new
	end


	# POST /addresses
	# POST /addresses.json
	def create
		@address = current_user.addresses.new(address_params)
		@earring = Earring.find(@address.detail.earring_id)

		respond_to do |format|
			if @address.save
				format.html { redirect_to "/confirm" }
				format.json { render action: 'show', status: :created, location: @address }
			else
				format.html { redirect_to "/addresses/new?d=#{@address.detail.id}" }
				format.json { render json: @address.errors, status: :unprocessable_entity }
			end
		end
	end


	private

		# Never trust parameters from the scary internet, only allow the white list through.
		def address_params
			params.require(:address).permit(:street, :street2, :city, :state, :zip, :detail_id, :user_id)
		end
end
