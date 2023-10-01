class AddNameToPromotions < ActiveRecord::Migration[6.1]
  def change
    add_column :promotions, :name, :string
  end
end
