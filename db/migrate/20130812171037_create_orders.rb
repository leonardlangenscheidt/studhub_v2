class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.integer :user_id
    	t.integer :earring_id
    	t.integer :price_paid
    	t.string :status
      	t.timestamps
    end
  end
end
