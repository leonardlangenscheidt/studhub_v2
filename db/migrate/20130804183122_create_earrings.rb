class CreateEarrings < ActiveRecord::Migration
  def change
    create_table :earrings do |t|
      t.string :vendor
      t.string :collection
      t.string :design
      t.string :material
      t.integer :size
      t.integer :price
      t.string :sku
      t.integer :inventory

      t.timestamps
    end
  end
end
