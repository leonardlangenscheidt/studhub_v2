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

  	def dashboard
  		unless current_user && (current_user.name = "Leonard Langenscheidt" || current_user.name = "Jennifer Liu")
			flash[:notice] = "Please don't mess around with our backend!"
			redirect_to root_path
		end
end
