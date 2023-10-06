class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
    # Check if user has an unpaid transaction and load that instead:
    @transaction = Transaction.create(user_id: 0) unless current_user
    @transaction = find_unpaid_transaction(current_user.id).first if current_user
    @transaction = Transaction.create(user_id: current_user.id) if current_user && @transaction.nil?
    @baskets = Basket.where(transaction_id: @transaction.id)
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
end
