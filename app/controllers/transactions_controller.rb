class TransactionsController < ApplicationController
  def index
    @user_id = current_user ? current_user.id : 0
    @transactions = Transaction.where(user_id: @user_id)
  end

  def show
    @user = current_user ? current_user : 0
    @transaction = Transaction.find(params[:id])
    @baskets = Basket.where(transaction_id: @transaction.id)
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


  def get_subtotal(baskets)
    subtotal = 0.0
    baskets.each do |basket|
      subtotal += basket.quantity * Item.find(basket.item_id).price
    end
    subtotal
  end
end
