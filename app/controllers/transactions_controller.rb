class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user ? current_user.id : 1
    if @transaction.save!
      redirect_to transaction_path(@transaction), notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:subtotal, :savings, :item_id, :user)
  end
end
