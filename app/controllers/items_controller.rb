class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
    # Check if user has an unpaid transaction and load that instead:
    @transaction = Transaction.create(user_id: 0) unless current_user
    @transaction = find_unpaid_transaction(current_user.id).first if current_user
    @transaction = Transaction.create(user_id: current_user.id) if current_user && @transaction.nil?
    @baskets = condense_baskets(Basket.where(transaction_id: @transaction.id))
    @basket = Basket.new
    @user = current_user ? current_user : "guest"
  end

  def show
    @user = current_user ? current_user : "guest"
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "Item successfully updated."
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:product_code, :name, :currency, :price, :description, :inventory_remaining, :category, :brand, :photo)
  end

  def find_unpaid_transaction(user_id)
    Transaction.where(user_id: user_id, paid: false)
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
end
