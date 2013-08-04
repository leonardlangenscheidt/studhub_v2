# require 'constants.rb'

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET, :display => 'popup'
end
