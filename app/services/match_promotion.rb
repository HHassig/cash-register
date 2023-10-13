class MatchPromotion
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def match
    promotion = Promotion.find_by(item_id: @item.id, active: true)
    {
      promotion: promotion,
      display_price: DisplayPrice.new(promotion).get_price
    }
  end
end
