class AddBrandToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :brand, :string
  end
end
