class AddDiscountToPromotions < ActiveRecord::Migration[7.0]
  def change
    add_column :promotions, :discount, :float
  end
end
