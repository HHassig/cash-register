require "rails_helper"
require "condense_baskets"

RSpec.describe CondenseBaskets do
  describe ".condense" do

    item1 = Item.create!(product_code: "GR1",
                          name: "Green Tea",
                          inventory_remaining: 1000,
                          price: 3.11)
    item2 = Item.create!(product_code: "SR1",
                          name: "Strawberries",
                          inventory_remaining: 1000,
                          price: 5.00)
    item3 = Item.create!(product_code: "CF1",
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

    transaction = Transaction.create!(user_id: 1)
    x = 0
    while x < 3
      Basket.create!(transaction_id: transaction.id,
                          item_id: item1.id,
                          quantity: 6,
                          promotion_id: promotion1.id,
                          cost_per_item: (Item.find(item1.id)).price)
      Basket.create!(transaction_id: transaction.id,
                          item_id: item2.id,
                          quantity: 3,
                          promotion_id: promotion2.id,
                          cost_per_item: (Item.find(item2.id)).price)
      Basket.create!(transaction_id: transaction.id,
                          item_id: item2.id,
                          quantity: 1,
                          promotion_id: promotion2.id,
                          cost_per_item: (Item.find(item2.id)).price)
      Basket.create!(transaction_id: transaction.id,
                          item_id: item3.id,
                          quantity: 4,
                          promotion_id: promotion3.id,
                          cost_per_item: (Item.find(item3.id)).price)
      x += 1
    end

    it 'Should return an array of basket hashes with correct quantities' do
      expect((CondenseBaskets.new(Basket.where(transaction_id: transaction.id)).condense)[0][:quantity]).to eq 18
      expect((CondenseBaskets.new(Basket.where(transaction_id: transaction.id)).condense)[1][:quantity]).to eq 12
      expect((CondenseBaskets.new(Basket.where(transaction_id: transaction.id)).condense)[2][:quantity]).to eq 12
    end

    it 'Should return an array of basket hashes with unique item_ids' do
      baskets = CondenseBaskets.new(Basket.where(transaction_id: transaction.id)).condense
      item_ids = []
      baskets.each do |basket|
        item_ids << basket[:item_id]
      end
      expect(item_ids.uniq.size == item_ids.size).to eq true
    end

    it 'Should return an array of basket hashes with the same transaction_id' do
      baskets = CondenseBaskets.new(Basket.where(transaction_id: transaction.id)).condense
      transaction_ids = []
      baskets.each do |basket|
        transaction_ids << basket[:trasnaction_id]
      end
      expect(transaction_ids.uniq.size).to eq 1
    end
  end
end



# condensed << { item_id: unique_items[index],
#   transaction_id: baskets[itemIndex[0]][:transaction_id],
#   promotion_id: baskets[itemIndex[0]][:promotion_id],
#   id: baskets[itemIndex[0]][:id],
#   quantity: quantities[index],
#   subtotal: quantity * baskets[itemIndex[0]][:cost_per_item],
#   cost_per_item: baskets[itemIndex[0]][:cost_per_item] }
