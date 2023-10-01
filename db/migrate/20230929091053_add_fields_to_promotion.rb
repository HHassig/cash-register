class AddFieldsToPromotion < ActiveRecord::Migration[6.1]
  def change
    add_column :promotions, :min_quantity, :integer
    add_column :promotions, :discount, :float
  end
end
