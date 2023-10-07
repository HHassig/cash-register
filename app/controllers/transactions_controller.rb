class TransactionsController < ApplicationController
  def index
    @user_id = current_user ? current_user.id : 0
    @transactions = Transaction.where(user_id: @user_id)
  end

  def show
    @user_id = current_user ? current_user.id : 0
    @transaction = Transaction.find(params[:id])
    @baskets = condense_baskets(Basket.where(transaction_id: @transaction.id))
    @transaction.savings = get_savings(@baskets)
    @transaction.subtotal = get_subtotal(@baskets) - @transaction.savings
    @transaction.save!
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = 1
    @transaction.save!
  end

  def edit
    @transaction = Transaction.find(params[:id])
    @transaction.paid = true
    redirect_to transaction_path(@transaction) if @transaction.save
  end

  private

  def transaction_params
    params.require(:transaction).permit(:subtotal, :savings, :item_id, :user_id)
  end

  def condense_baskets(baskets)
    condensed = []
    unique_items = baskets.distinct.pluck(:item_id)
    unique_items_info = []
    quantities =[]
    indexes = []
    unique_items.each do |item|
      quantity = 0
      temp = []
      baskets.each_with_index do |basket, index|
        if item == basket.item_id
          quantity += basket.quantity
          temp << index
        end
      end
      indexes << temp
      quantities << quantity
    end
    indexes.each_with_index do |oldIndex, index|
      quantity = quantities[index]
      item_id = unique_items[index]
      transaction_id = baskets[oldIndex[0]][:transaction_id]
      id = baskets[oldIndex[0]][:id]
      promotion_id = baskets[oldIndex[0]][:promotion_id]
      subtotal = quantity * baskets[oldIndex[0]][:cost_per_item]
      condensed << { item_id: item_id,
        transaction_id: transaction_id,
        promotion_id: promotion_id,
        id: id,
        quantity: quantity,
        subtotal: subtotal,
        cost_per_item: baskets[oldIndex[0]][:cost_per_item] }
    end
    condensed
  end

  def get_subtotal(baskets)
    subtotal = 0.0
    baskets.each do |basket|
      subtotal += basket[:quantity] * Item.find(basket[:item_id]).price
    end
    subtotal
  end

  def get_savings(baskets)
    savings = 0.0
    savings_array = []
    baskets.each do |basket|
      if basket[:promotion_id] > 0
        savings += basket[:quantity] * (Item.find(basket[:item_id]).price - Promotion.find(basket[:promotion_id]).promo_price)
      end
    end
    savings
  end
end
