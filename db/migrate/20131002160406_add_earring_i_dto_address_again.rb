class AddEarringIDtoAddressAgain < ActiveRecord::Migration
  def change
  	add_column :addresses, :earring_id, :integer
  end
end
