class Detail < ActiveRecord::Base
	belongs_to :user
	belongs_to :earring
	belongs_to :address
end
