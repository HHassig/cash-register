class AddFieldsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :subtotal, :float
    add_column :transactions, :savings, :float
  end
end
