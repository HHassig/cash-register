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
        display_price: DisplayPrice.new(promotion).get_price,
        minimum_quantity: promotion.min_quantity,
        promotion: promotion
      }
    end
  end
end
