class AddDetail < ActiveRecord::Migration
  def change
	create_table :details do |t|
		t.integer :user_id
		t.integer :earring_id
		t.boolean :buy
		t.boolean :right
		t.boolean :used
	end
  end
end
