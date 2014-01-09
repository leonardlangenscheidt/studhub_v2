class DetailsController < ApplicationController

	# def new
	# 	@detail = Detail.new
	# 	@earring = Earring.find(params[:id])
	# 	render 'earrings/show'
	# end


	# POST /addresses
	# POST /addresses.json
	def create
		@detail = Detail.new(detail_params)
		if @detail.save
			redirect_to "/addresses/new?d=#{@detail.id}"
			# flash[:notice] = "Woo!"
			# redirect_to "/earrings"
			# format.html { redirect_to "/addresses/new?d=#{@detail.id}" }
			# format.json { render action: 'show', status: :created, location: @address }
		else
			flash[:notice] = "Oops! Something went wrong."
			redirect_to "/earrings"
			# format.html { redirect_to "/addresses/new?earring_id=#{@earring.id}&buy=#{@address.buy}&right=#{@address.buy}&used=#{@address.used}" }
			# format.json { render json: @address.errors, status: :unprocessable_entity }
		end
	end



	private

	def detail_params
		params.require(:detail).permit(:buy, :right, :used, :earring_id, :user_id)
	end
end
