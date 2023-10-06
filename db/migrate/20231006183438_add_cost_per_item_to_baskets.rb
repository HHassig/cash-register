class AddCostPerItemToBaskets < ActiveRecord::Migration[7.0]
  def change
    add_column :baskets, :cost_per_item, :float
  end
end
