class MatchPromotion
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def match
    promotion = Promotion.find_by(item_id: @item.id, active: true)
    {
      promotion: promotion,
      display_price: get_promotion_price(promotion),
      minimum_quantity: promotion.min_quantity
    }
  end

  private

  def get_promotion_price(promotion)
    return nil if promotion.nil?
    return promotion.kind == "bogo" ? "Buy 1 Get 1" : "€#{promotion.promo_price}"
  end
end
