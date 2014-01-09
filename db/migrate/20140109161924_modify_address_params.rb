class ModifyAddressParams < ActiveRecord::Migration
  def change
  	remove_column :addresses, :earring_id
  	remove_column :addresses, :buy
  	remove_column :addresses, :right
  	remove_column :addresses, :used
  	add_column :addresses, :detail_id, :integer
  end
end
