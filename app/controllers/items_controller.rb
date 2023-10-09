class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
    @basket = Basket.new
    # Check if user has an unpaid transaction and load that instead of a new transaction:
    @transaction = SetTransaction.new(current_user).set_transaction
    @baskets = CondenseBaskets.new(Basket.where(transaction_id: @transaction.id)).condense
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item), notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
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
end
