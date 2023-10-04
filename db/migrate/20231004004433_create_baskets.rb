class CreateBaskets < ActiveRecord::Migration[7.0]
  def change
    create_table :baskets do |t|
      t.integer :item_id
      t.integer :transaction_id
      t.integer :quantity
      t.integer :promotion_id
      t.timestamps
    end
  end
end
