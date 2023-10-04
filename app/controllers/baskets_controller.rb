class BasketsController < ApplicationController
  def new
    @basket = Basket.new
  end

  def create
    @basket = Basket.new(basket_params)
    @basket.save!
  end

  private

  def basket_params
    params.require(:basket).permit(:item_id, :transaction_id, :promotion_id, :quantity)
  end
end
