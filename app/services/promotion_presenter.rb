class PromotionPresenter
  attr_reader :promotions

  def initialize(promotions)
    @promotions = promotions
  end

  def to_hash
    @promotions.map do |promotion|
      item = Item.find(promotion.item_id)
      {
        item: item,
        display_price: get_promotion_price(promotion),
        minimum_quantity: promotion.min_quantity,
        promotion: promotion
      }
    end
  end

  private

  def get_promotion_price(promotion)
    return nil if promotion.nil?
    return promotion.kind == "bogo" ? "Buy 1 Get 1" : "€#{'%.2f' % promotion.promo_price}"
  end
end
