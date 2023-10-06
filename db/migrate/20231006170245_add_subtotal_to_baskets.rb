class AddSubtotalToBaskets < ActiveRecord::Migration[7.0]
  def change
    add_column :baskets, :subtotal, :float
  end
end
