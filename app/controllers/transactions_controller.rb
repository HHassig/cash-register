class TransactionsController < ApplicationController
  def index
    @user_id = current_user ? current_user.id : 0
    @transactions = Transaction.where(user_id: @user_id)
  end

  def show
    @user = current_user ? current_user : 0
    @transaction = Transaction.find(params[:id])
    @baskets = condense_baskets(Basket.where(transaction_id: @transaction.id))
    @transaction.subtotal = get_subtotal(@baskets)
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
    if @transaction.save
      redirect_to transaction_path(@transaction)
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:subtotal, :savings, :item_id, :user_id)
  end

  def condense_baskets(baskets)
    condensed = []
    unique_items = baskets.distinct.pluck(:item_id)
    unique_items.each do |item|
      quantity = 0
      temp = []
      baskets.each_with_index do |basket, index|
        if item == basket.item_id
          quantity += basket.quantity
        end
        temp = [basket, quantity]
      end
      condensed << { item_id: item,
        transaction_id: temp[0].transaction_id,
        promotion_id: temp[0].promotion_id,
        quantity: temp[1] }
    end
    condensed
  end

  def get_subtotal(baskets)
    subtotal = 0.0
    baskets.each do |basket|
      if basket[:promotion_id] < 1
        subtotal += basket[:quantity] * Item.find(basket[:item_id]).price
      else
        if basket[:quantity] >= Promotion.find(basket[:promotion_id]).min_quantity
          subtotal += basket[:quantity] * Promotion.find(basket[:promotion_id]).promo_price
        else
          subtotal += basket[:quantity] * Item.find(basket[:item_id]).price
        end
      end
    end
    subtotal
  end
end
