require "rails_helper"
require "set_transaction"

RSpec.describe SetTransaction do
  describe ".set_transaction" do

    it "Should load a new transaction if user is not logged in" do
      current_user = nil
      transaction = SetTransaction.new(current_user).set_transaction
      expect(transaction).to eq Transaction.last
    end

    it "Should load a new transaction if user is logged in and has no unpaid transactions" do
      user = User.create!(email: "new@rspec.com",
                          password: "123456")
      transaction = Transaction.create!(user_id: user.id,
                                        paid: true)
      new_transaction = SetTransaction.new(user).set_transaction
      expect(new_transaction.id).to eq transaction.id + 1
    end

    it "Should load the last unpaid transaction if user is logged in and has an unpaid transaction" do
      user = User.create!(email: "new@rspec.com",
        password: "123456")
      transaction = Transaction.create!(user_id: user.id,
                            paid: false)
      new_transaction = SetTransaction.new(user).set_transaction
      expect(new_transaction.id).to eq transaction.id
    end
  end
end
