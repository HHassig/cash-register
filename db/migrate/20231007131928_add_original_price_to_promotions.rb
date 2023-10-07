class AddOriginalPriceToPromotions < ActiveRecord::Migration[7.0]
  def change
    add_column :promotions, :original_price, :float
  end
end
