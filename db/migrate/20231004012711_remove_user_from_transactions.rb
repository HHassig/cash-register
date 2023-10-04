class RemoveUserFromTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :transactions, :user, null: false, foreign_key: true
  end
end
