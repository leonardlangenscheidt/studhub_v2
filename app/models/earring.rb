class Earring < ActiveRecord::Base
	has_attached_file :image, styles: { large: "640x480>", medium: "320x240>", :small => "160x120>"}
	validates_attachment :image, presence: true
	has_many :orders
end
