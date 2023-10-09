require "rails_helper"
require "update_transaction"

RSpec.describe UpdateTransaction do
  describe ".update_transaction_total" do
    # Set up
    item1 = Item.create!(
      product_code: "GR1",
      name: "Green Tea",
      inventory_remaining: 1000,
      price: 3.11)
    item2 = Item.create!(
      product_code: "SR1",
      name: "Strawberries",
      inventory_remaining: 1000,
      price: 5.00)
    item3 = Item.create!(
      product_code: "CF1",
      name: "Coffee",
      inventory_remaining: 1000,
      price: 11.23)

    promotion1 = Promotion.create!(item_id: item1.id,
      kind: "bogo",
      name: "CEO ❤️ GT",
      active: true,
      min_quantity: 2,
      promo_price: item1.price / 2)
    promotion2 = Promotion.create!(item_id: item2.id,
      kind: "bulk",
      name: "Strawberries Bulk",
      active: true,
      min_quantity: 3,
      promo_price: 4.50)
    promotion3 = Promotion.create!(item_id: item3.id,
      kind: "bulk",
      name: "Coffee Bulk",
      active: true,
      min_quantity: 3,
      promo_price: item3.price * 2 /3)

    basket1 = Basket.create!(transaction_id: 1,
                        item_id: item1.id,
                        quantity: 2,
                        promotion_id: promotion1.id)
    basket2 = Basket.create!(transaction_id: 2,
                      item_id: item2.id,
                      quantity: 3,
                      promotion_id: promotion2.id)
    basket3 = Basket.create!(transaction_id: 3,
                      item_id: item2.id,
                      quantity: 1,
                      promotion_id: promotion2.id)
    basket4 = Basket.create!(transaction_id: 3,
      item_id: item3.id,
      quantity: 3,
      promotion_id: promotion3.id)

    it "Should return a subtotal of 3.11 for: 1 GR1" do
      transaction = Transaction.new(user_id: 1)
      baskets = [basket1]
      UpdateTransaction.new(transaction, baskets).update_transaction_savings
      UpdateTransaction.new(transaction, baskets).update_transaction_total
      expect(transaction.subtotal).to eq 3.11
    end

    it "Should return a savings of 3.11 for: 1 GR1" do
      transaction = Transaction.new(user_id: 1)
      baskets = [basket1]
      UpdateTransaction.new(transaction, baskets).update_transaction_savings
      expect(transaction.savings).to eq 3.11
    end

    it "Should return a subtotal of 16.61 for: 3 SR1's and 1 GR1" do
      transaction = Transaction.new(user_id: 1)
      baskets = [basket1, basket2]
      UpdateTransaction.new(transaction, baskets).update_transaction_savings
      UpdateTransaction.new(transaction, baskets).update_transaction_total
      expect(transaction.subtotal).to eq 16.61
    end

    it "Should return a savings of 4.61 for: 3 SR1's and 1 GR1" do
      transaction = Transaction.new(user_id: 1)
      baskets = [basket1, basket2]
      UpdateTransaction.new(transaction, baskets).update_transaction_savings
      expect(transaction.savings.round(2)).to eq 4.61
    end

    it "Should return a subtotal of 30.57 for 3 CF1's, 1 GR1, and 1 SR1" do
      transaction = Transaction.new(user_id: 1)
      baskets = [basket1, basket3, basket4]
      UpdateTransaction.new(transaction, baskets).update_transaction_savings
      UpdateTransaction.new(transaction, baskets).update_transaction_total
      expect(transaction.subtotal.round(2)).to eq 30.57
    end

    it "Should return a savings of 14.34 for 3 CF1's, 1 GR1, and 1 SR1" do
      transaction = Transaction.new(user_id: 1)
      baskets = [basket1, basket3, basket4]
      UpdateTransaction.new(transaction, baskets).update_transaction_savings
      expect(transaction.savings.round(2)).to eq 14.34
    end
  end
end
