class SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: :create

	def create
		 auth = request.env['omniauth.auth']
		# Find an identity here
		@identity = Identity.find_with_omniauth(auth)

		if @identity.nil?
			# If no identity was found, create a brand new one here
			@identity = Identity.create_with_omniauth(auth)
		end

		unless current_user == nil
			if @identity.user_id == current_user.id
				# User is signed in so they are trying to link an identity with their
				# account. But we found the identity and the user associated with it
				# is the current user. So the identity is already associated with
				# this user. So let's display an error message.
				flash[:notice] = "Already linked that account! Case 1"
				# redirect_to root_url
			else
				# The identity is not associated with the current_user so lets
				# associate the identity
				@identity.user_id = current_user.id
				@identity.save()
				flash[:notice] = "Successfully linked that account! Case 2"
				# redirect_to root_url
			end
		  else
			if @identity.user.present?
				# The identity we found had a user associated with it so let's
				# just log them in here
				self.current_user = @identity.user
				flash[:notice] = "Signed in! Case 3"
				# redirect_to root_url
			else
				# No user associated with the identity so we need to create a new one
				@user = User.create_with_omniauth(auth)
				@identity.user_id = @user.id
				@identity.save()
				self.current_user = @identity.user
				flash[:notice] = "Signed up! Case 4"
				# redirect_to root_url
			end
		  end

		# user = User.from_omniauth(auth)
		# session[:user_id] = @user.id
		redirect_to root_url
	end

	def destroy
		self.current_user = nil
		flash[:notice] = "Signed out! Case 5"
		redirect_to root_url
	end

	# def destroy
	# 	session[:user_id] = nil
	# 	redirect_to root_url
	# end
end

 # uid = request.env['omniauth.auth'].uid
 #    user = User.where(uid: uid).first_or_create
