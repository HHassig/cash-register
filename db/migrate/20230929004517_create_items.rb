class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :product_code
      t.string :name
      t.string :currency
      t.float :price
      t.string :description
      t.integer :inventory_remaining

      t.timestamps
    end
  end
end
