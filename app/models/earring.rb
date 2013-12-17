class Earring < ActiveRecord::Base
	has_attached_file :image, styles: { large: "980x980>", medium: "480x480>", :small => "240x240>"}
	has_attached_file :imageleft, styles: { large: "980x980>", medium: "480x480>", :small => "240x240>"}
	has_attached_file :imageright, styles: { large: "980x980>", medium: "480x480>", :small => "240x240>"}
	validates_attachment :image, presence: true
	has_many :orders
	validates :vendor, :collection, :design, :material, :size, :price, :sku, :inventory, :used_inventory, :description, presence: true
end
