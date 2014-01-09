class Detail < ActiveRecord::Base
	validates :buy, :used, :right, presence: true
	belongs_to :user
	belongs_to :earring
	belongs_to :address
end
