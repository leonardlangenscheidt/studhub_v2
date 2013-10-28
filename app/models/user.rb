class User < ActiveRecord::Base
	has_many :identities
  	has_many :orders
	has_many :addresses

  	def self.create_with_omniauth(info)
    		create(name: info['name'], email: info['email'])
  	end

	# def self.from_omniauth(auth)
	# 	where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	# 		user.provider = auth.provider
	# 		user.uid = auth.uid
	# 		user.name = auth.info.name
	# 		user.email = auth.info.email
	# 		user.oauth_token = auth.credentials.token
	# 		user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	# 		user.save!
	# 	end
	# end

	# def self.find_with_omniauth(auth)
	# 	find_by_provider_and_uid(auth['provider'], auth['uid'])
 #  	end


	# belongs_to :identity
end
