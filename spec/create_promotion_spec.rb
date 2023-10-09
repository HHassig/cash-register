require "rails_helper"
require "create_promotion"

RSpec.describe CreatePromotion do
  describe ".create" do
    item1 = Item.create!(product_code: "GR1",
                          name: "Green Tea",
                          inventory_remaining: 1000,
                          price: 3.11)
    it "Should set promo_price to 1/2 on BOGO deals" do
      promotion_params = {name: "testBOGO",
                          kind: "bogo",
                          item_id: item1.id}
      puts promotion_params
      CreatePromotion.new(promotion_params).create
      expect(Promotion.last.promo_price).to eq item1.price / 2
    end

    it "Should set minimum quantity to 2 on BOGO deals" do
      promotion_params = {name: "testBOGO",
                          kind: "bogo",
                          item_id: item1.id}
      CreatePromotion.new(promotion_params).create
      expect(Promotion.last.min_quantity).to eq 2
    end

    it "Should set promo price if deal is 'bulk' and promo_price is empty but discount exists" do
      promotion_params = {name: "testbulk",
                          kind: "bulk",
                          item_id: item1.id,
                          min_quantity: 3,
                          discount: 0.50}
      CreatePromotion.new(promotion_params).create
      expect(Promotion.last.promo_price).to eq 1.555
    end
  end
end
