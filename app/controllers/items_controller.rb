class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
    @transaction = Transaction.create(user_id: current_user ? current_user.id : 0)
    @basket = Basket.new
  end

  def show
    @item = Item.find(params[:id])
  end
end
