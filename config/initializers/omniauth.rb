# require 'constants.rb'

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :display => 'popup', :image_size => 'normal'
	# provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET, :display => 'popup'
end
