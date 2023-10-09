class BasketDestroyer
  attr_reader :baskets

  def initialize(baskets)
    @baskets = baskets
  end

  def destroy_baskets
    # Check that transaction is unpaid:
    unless Transaction.find(@baskets.first.transaction_id).paid?
      @baskets.each do |basket|
        basket.destroy
      end
    end
  end
end
