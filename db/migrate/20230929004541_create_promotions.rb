class CreatePromotions < ActiveRecord::Migration[6.1]
  def change
    create_table :promotions do |t|
      t.string :type
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
