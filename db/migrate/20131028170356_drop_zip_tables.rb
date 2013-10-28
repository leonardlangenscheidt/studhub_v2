class DropZipTables < ActiveRecord::Migration
  def change
  	drop_table :counties
  	drop_table :states
  	drop_table :zipcodes
  end
end
