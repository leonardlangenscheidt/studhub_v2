class CreateUserAndIdentitySetup < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.references :user
      t.string :oauth_token
      t.datetime :oauth_expires_at
    end

    add_index :identities, :user_id
  end
end
