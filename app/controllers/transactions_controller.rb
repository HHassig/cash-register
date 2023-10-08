class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.where(user_id: current_user.id)
  end

  def show
    @transaction = Transaction.find(params[:id])
    @baskets = CondenseBaskets.new(Basket.where(transaction_id: @transaction.id)).condense
    # A user is automatically redirected here on checkout so the following two lines always occur
    @transaction.savings = @transaction.get_savings(@baskets)
    @transaction.subtotal = @transaction.get_subtotal(@baskets) - @transaction.savings
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
    redirect_to transaction_path(@transaction) if @transaction.save
  end

  private

  def transaction_params
    params.require(:transaction).permit(:subtotal, :savings, :item_id, :user_id)
  end
end
