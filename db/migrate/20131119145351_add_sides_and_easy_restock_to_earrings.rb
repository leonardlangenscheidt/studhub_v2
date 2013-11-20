class AddSidesAndEasyRestockToEarrings < ActiveRecord::Migration
  def change
  	add_column :earrings, :sides, :boolean
  	add_column :earrings, :easyRestock, :boolean
  end
end
