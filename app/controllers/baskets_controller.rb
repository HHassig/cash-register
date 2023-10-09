class BasketsController < ApplicationController
  def new
    @basket = Basket.new
  end

  def create
    @basket = Basket.new(basket_params)
    @basket.save!
  end

  def destroy
    BasketDestroyer.new(Basket.where(item_id: Basket.find(params[:id]).item_id,
                                    transaction_id: Basket.find(params[:id]).transaction_id)).destroy_baskets
    # This seems sloppy, but the fallback is the current transaction, found through the current basket's transactionID
    redirect_back(fallback_location: transaction_path(Transaction.find(Basket.find(params[:id]).transaction_id)))
  end

  private

  def basket_params
    params.require(:basket).permit(:item_id, :transaction_id, :promotion_id, :quantity, :subtotal, :cost_per_item)
  end
end
