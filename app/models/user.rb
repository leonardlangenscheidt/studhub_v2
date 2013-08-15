class User < ActiveRecord::Base
	def self.from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
			user.provider = auth.provider
				user.uid = auth.uid
				user.name = auth.info.name
				user.email = auth.info.email
				user.oauth_token = auth.credentials.token
				user.oauth_expires_at = Time.at(auth.credentials.expires_at)
				user.save!
		end
	end

	# def self.from_form(add_form)
	# 	@user.update(@user.street = params[:street])
	# 		@user.street2 = params[:street2],
	# 		@user.city = params[:city],
	# 		@user.state = params[:state],
	# 		@user.zip = params[:zip]
	# 		)
	# end

	has_many :orders

	has_attached_file :image, styles: { medium: "320x240>", :small => "160x120>"}
end
