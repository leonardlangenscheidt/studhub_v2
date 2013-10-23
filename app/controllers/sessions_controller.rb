class SessionsController < ApplicationController
		def create
			user = User.from_omniauth(request.env['omniauth.auth'])
			session[:user_id] = user.id
			redirect_to :root
		end

		def destroy
				session[:user_id] = nil
				redirect_to root_url
		end
end

 # uid = request.env['omniauth.auth'].uid
 #    user = User.where(uid: uid).first_or_create
