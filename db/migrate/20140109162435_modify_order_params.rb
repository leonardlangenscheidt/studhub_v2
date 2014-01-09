class ModifyOrderParams < ActiveRecord::Migration
  def change
  	remove_column :orders, :earring_id
  	remove_column :orders, :number
  	add_column :orders, :quantity, :integer
  end
end
