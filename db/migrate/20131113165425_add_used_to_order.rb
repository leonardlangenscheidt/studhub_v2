class AddUsedToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :used, :boolean
  end
end
