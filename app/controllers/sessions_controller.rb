class SessionsController < ApplicationController
  	def create
    		if params[:provider] == 'facebook'
 	   		user = User.from_omniauth(env["omniauth.auth"])
    			session[:user_id] = user.id
    			redirect_to root_url
    		else
    			user = User.from_omniauth(params[:code])
    			session[:user_id] = user.id
    			redirect_to root_url
    		end
  	end

  	def destroy
    		session[:user_id] = nil
    		redirect_to root_url
  	end
end
