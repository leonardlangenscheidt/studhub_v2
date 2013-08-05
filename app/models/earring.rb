class Earring < ActiveRecord::Base
	has_attached_file :image, styles: { medium: "320x240>"}
end
