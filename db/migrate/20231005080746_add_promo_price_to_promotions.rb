class AddPromoPriceToPromotions < ActiveRecord::Migration[7.0]
  def change
    add_column :promotions, :promo_price, :float
  end
end
