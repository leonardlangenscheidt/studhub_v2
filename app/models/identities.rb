class Identity < ActiveRecord::Base
	belongs_to :user

  	def self.find_with_omniauth(auth)
    		find_by_provider_and_uid(auth['provider'], auth['uid'])
  	end

  	# def self.create_with_omniauth(auth)
   #  		create(uid: auth['uid'], provider: auth['provider'])
  	# end

	def self.create_with_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |identity|
			identity.provider = auth.provider
			identity.uid = auth.uid
			identity.oauth_token = auth.credentials.token
			identity.oauth_expires_at = Time.at(auth.credentials.expires_at)
			identity.save!
		end
	end
end
