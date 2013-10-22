# require 'constants.rb'

Rails.application.config.middleware.use OmniAuth::Builder do
	# provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :display => 'popup', :image_size => 'normal'
	# provider :paypal, ENV['PAYPAL_KEY'], ENV['PAYPAL_SECRET'], sandbox: true, scope: "openid"
	provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET, :display => 'popup'
	provider :paypal, PAYPAL_KEY, PAYPAL_SECRET, sandbox: true, scope: "openid"
	provider :dwolla, ENV['DWOLLA_KEY'], ENV['DWOLLA_SECRET'], :scope => 'accountinfofull|send|request', :display => 'popup', :image_size => 'normal', :provider_ignores_state => true
end
