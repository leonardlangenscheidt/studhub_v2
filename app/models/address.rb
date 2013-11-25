class Address < ActiveRecord::Base
	validates :street, :zip, :city, :state, presence: true
	belongs_to :user
	belongs_to :order
	belongs_to :earring
end
