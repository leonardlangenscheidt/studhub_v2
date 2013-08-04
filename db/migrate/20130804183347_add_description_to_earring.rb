class AddDescriptionToEarring < ActiveRecord::Migration
  def change
  	add_column :earrings, :description, :text
  end
end
