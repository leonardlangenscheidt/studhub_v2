class AddAttachmentImagerightToEarrings < ActiveRecord::Migration
  def self.up
    change_table :earrings do |t|
      t.attachment :imageright
    end
  end

  def self.down
    drop_attached_file :earrings, :imageright
  end
end
