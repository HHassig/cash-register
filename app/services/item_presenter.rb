class ItemPresenter
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def to_hash
    @items.map do |item|
      promotion = Promotion.find_by(item_id: item.id, active: true)
      {
        item: item,
        promotion: promotion,
        display_price: get_promotion_price(promotion)
      }
    end
  end

  private

  def get_promotion_price(promotion)
    return nil if promotion.nil?
    return promotion.kind == "bogo" ? "Buy 1 Get 1" : "€#{'%.2f' % promotion.promo_price}"
  end
end
