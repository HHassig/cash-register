class RemoveTypeFromPromotions < ActiveRecord::Migration[6.1]
  def change
    remove_column :promotions, :type, :string
  end
end
