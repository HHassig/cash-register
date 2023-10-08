class Transaction < ApplicationRecord

  def get_subtotal(baskets)
    subtotal = 0.0
    baskets.each do |basket|
      subtotal += basket[:quantity] * Item.find(basket[:item_id]).price
    end
    subtotal
  end

  def get_savings(baskets)
    savings = 0.0
    baskets.each do |basket|
      if basket[:promotion_id] > 0
        savings += basket[:quantity] * (Item.find(basket[:item_id]).price - Promotion.find(basket[:promotion_id]).promo_price)
      end
    end
    savings
  end

  def find_unpaid_transaction(user_id)
    #Finds the last unpaid transaction of the current user
    Transaction.where(user_id: user_id, paid: false)
  end
end
