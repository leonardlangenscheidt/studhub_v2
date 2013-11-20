class MoveAttrToAddress < ActiveRecord::Migration
  def change
  	add_column :addresses, :right, :boolean
  	add_column :addresses, :used, :boolean
  	remove_column :orders, :used
  	remove_column :orders, :buy
  end
end
