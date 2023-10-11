class BasketPresenter
  attr_reader :baskets

  def initialize(baskets)
    @baskets = baskets
  end

  def to_hash
    @baskets.map do |basket|
      promotion = get_promotion(basket)
      price = get_price(basket, promotion)
      {
        price: price,
        item: Item.find(basket[:item_id]),
        promotion_id: promotion.nil? ? 0 : promotion.id,
        subtotal: basket[:quantity] * price,
        quantity: basket[:quantity],
        basket: basket
      }
    end
  end

  private

  def get_promotion(basket)
    basket[:promotion_id].positive? ? Promotion.find(basket[:promotion_id]) : nil
  end

  def get_price(basket, promotion)
    promotion.nil? ? basket[:cost_per_item] : promotion.promo_price
  end
end
