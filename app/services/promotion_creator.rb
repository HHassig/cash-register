class PromotionCreator
  attr_reader :promotion_params

  def initialize(promotion_params)
    @promotion_params = promotion_params
  end

  def create_promotion
    promotion = Promotion.new(@promotion_params)
    promotion.active = true
    promotion.original_price = Item.find(promotion.item_id).price
    promotion.promo_price = (promotion.original_price * promotion.discount) if promotion.promo_price.nil? && !promotion.discount.nil?
    if promotion.kind == "bogo"
      promotion.promo_price = promotion.original_price / 2
      promotion.min_quantity = 2
    end
    promotion.save!
  end
end
