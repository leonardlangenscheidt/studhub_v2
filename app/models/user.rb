class User < ActiveRecord::Base
	has_many :identities
  	has_many :orders
	has_many :addresses

  	def self.create_with_omniauth(auth)
    		create(name: auth.info.name, email: auth.info.email)
  	end

	# def self.create_with_omniauth(auth)
	# 	where(auth).first_or_initialize.tap do |user|
	# 		user.name = auth.info.name
	# 		user.email = auth.info.email
	# 		user.save!
	# 	end
	# end

	# def self.find_with_omniauth(auth)
	# 	find_by_provider_and_uid(auth['provider'], auth['uid'])
 #  	end


	# belongs_to :identity
end
