class AddBosToAddress < ActiveRecord::Migration
  def change
  	add_column :addresses, :buy, :boolean
  end
end
