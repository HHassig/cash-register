class UpdateTransaction
  attr_reader :transaction, :baskets

  def initialize(transaction, baskets)
    @transaction = transaction
    @baskets = baskets
  end

  def upate_tranasction_total
    subtotal = 0.0
    @baskets.each do |basket|
      subtotal += basket[:quantity] * Item.find(basket[:item_id]).price
    end
    @transaction.subtotal = subtotal
    @transaction.save!
  end

  def upate_tranasction_savings
    savings = 0.0
    @baskets.each do |basket|
      promotion = Promotion.find(basket[:promotion_id])
      if basket[:promotion_id].positive? && basket[:quantity] >= promotion.min_quantity
        savings += basket[:quantity] * (Item.find(basket[:item_id]).price - promotion.promo_price)
      end
    end
    @transaction.savings = savings
    @transaction.save!
  end
end
