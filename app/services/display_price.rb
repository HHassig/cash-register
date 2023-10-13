class DisplayPrice
  attr_reader :promotion

  def initialize(promotion)
    @promotion = promotion
  end

  def get_price
    return nil if @promotion.nil?
    return @promotion.kind == "bogo" ? "Buy 1 Get 1" : "€#{'%.2f' % @promotion.promo_price}"
  end
end
