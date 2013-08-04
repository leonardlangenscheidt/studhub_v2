class EarringsController < ApplicationController
	def index
		@earrings = Earring.all
	end

	def show
		@earring = Earring.find(params[:id])
	end

	private

	def earring_params
			params.require(:earring).permit(:vendor, :collection, :design, :material, :size, :price, :sku, :inventory, :description)
	end
end
