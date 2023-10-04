class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
    @transaction = Transaction.create
    @basket = Basket.new
  end

  def show
    @item = Item.find(params[:id])
  end
end
