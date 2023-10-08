class CondenseBaskets
  attr_reader :baskets

  def initialize(baskets)
    @baskets = baskets
  end

  def condense
    # This function condenses all baskets with the same item into one basket with the total quantity of items
    # I struggled to make it shorter, as the basket information hash needed to be passed
    condensed = []
    unique_items = baskets.distinct.pluck(:item_id)
    quantities = []
    quantity = 0
    index_of_items = []
    unique_items.each do |item|
      quantity = 0
      temp = []
      @baskets.each_with_index do |basket, index|
        if item == basket.item_id
          quantity += basket.quantity
          temp << index
        end
      end
      index_of_items << temp
      quantities << quantity
    end
    index_of_items.each_with_index do |itemIndex, index|
      condensed << { item_id: unique_items[index],
                      transaction_id: baskets[itemIndex[0]][:transaction_id],
                      promotion_id: baskets[itemIndex[0]][:promotion_id],
                      id: baskets[itemIndex[0]][:id],
                      quantity: quantities[index],
                      subtotal: quantity * baskets[itemIndex[0]][:cost_per_item],
                      cost_per_item: baskets[itemIndex[0]][:cost_per_item] }
    end
    condensed
  end
end
