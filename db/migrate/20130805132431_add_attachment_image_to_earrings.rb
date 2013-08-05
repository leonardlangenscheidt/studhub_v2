class AddAttachmentImageToEarrings < ActiveRecord::Migration
  def self.up
    change_table :earrings do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :earrings, :image
  end
end
