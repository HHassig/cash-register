class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
  end

  def show
    @item = Item.find(params[:id])
  end
end
