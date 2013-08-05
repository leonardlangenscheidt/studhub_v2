class Earring < ActiveRecord::Base
	has_attached_file :image, styles: { medium: "320x240>"}
	validates_attachment :image, presence: true
end
