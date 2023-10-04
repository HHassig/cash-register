class AddPaidToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :paid, :boolean, default: false
  end
end
