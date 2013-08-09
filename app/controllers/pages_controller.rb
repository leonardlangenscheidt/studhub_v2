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
end
