class Earring < ActiveRecord::Base
	has_attached_file :image, styles: { medium: "320x240>", :small => "160x120>"}
	validates_attachment :image, presence: true
end
