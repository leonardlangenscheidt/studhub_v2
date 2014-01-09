class UserMailer < ActionMailer::Base
  	default from: "from@example.com"

  	def purchase_email(order)
		@user = order.user
		@order = order
		@address = order.address
            @detail = @address.detail
		# @url  = 'http://example.com/login'
		mail(to: @user.email, subject: 'Your Purchase on Stud & Found')
  	end
  	def sell_email(order)
		@user = order.user
		@order = order
		@address = order.address
            @detail = @address.detail
		# @url  = 'http://example.com/login'
		mail(to: @user.email, subject: 'Your Sale on Stud & Found')
  	end
  	def shipping_email(order)
  		@order = order
  		@user = @order.user
  		mail(to: @user.email, subject: 'Your Order has shipped!')
  	end
  	def arrival_email(order)
  		@order = order
  		@user = @order.user
  		mail(to: @user.email, subject: 'Your earring has been received!')
  	end
end
