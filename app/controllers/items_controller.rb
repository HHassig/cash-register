class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Item.distinct.pluck(:category)
    # Check if user has an unpaid transaction and load that instead:
    @transaction = current_user ? find_unpaid_transaction(current_user.id).first : Transaction.create(user_id: 0)
    @basket = Basket.new
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def find_unpaid_transaction(user_id)
    Transaction.where(user_id: user_id, paid: false)
  end
end
