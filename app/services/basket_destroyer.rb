class BasketDestroyer
  attr_reader :baskets

  def initialize(baskets)
    @baskets = baskets
  end

  def destroy_baskets
    @baskets.each do |basket|
      basket.destroy
    end
  end
end
