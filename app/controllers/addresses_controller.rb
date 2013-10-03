class AddressesController < ApplicationController

  # GET /addresses/new
  def new
    @earring = Earring.find(params[:earring_id])
    @buy = params[:buy]
    @lastaddress = current_user.addresses.last
    @address = current_user.addresses.new
  end


  # POST /addresses
  # POST /addresses.json
  def create
    @address = current_user.addresses.new(address_params)
    @earring = Earring.find(address_params[:earring_id])
    @buy = address_params[:buy]

    respond_to do |format|
      if @address.save
        format.html { redirect_to "/earrings/#{@earring.id}/#{@buy}/confirm"}
        format.json { render action: 'show', status: :created, location: @address }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:street, :street2, :city, :state, :zip, :earring_id, :buy)
    end
end
