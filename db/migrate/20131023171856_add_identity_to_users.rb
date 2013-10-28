class AddIdentityToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :identity_id, :integer
  end
end
