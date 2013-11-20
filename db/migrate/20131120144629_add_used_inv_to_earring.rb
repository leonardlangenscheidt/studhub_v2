class AddUsedInvToEarring < ActiveRecord::Migration
  def change
  	add_column :earrings, :used_inventory, :integer
  end
end
