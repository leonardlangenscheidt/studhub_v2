class AddAttachmentImageleftToEarrings < ActiveRecord::Migration
  def self.up
    change_table :earrings do |t|
      t.attachment :imageleft
    end
  end

  def self.down
    drop_attached_file :earrings, :imageleft
  end
end
