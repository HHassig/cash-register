class AddActiveToPromotions < ActiveRecord::Migration[7.0]
  def change
    add_column :promotions, :active, :boolean
  end
end
