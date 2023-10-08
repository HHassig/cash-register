class SetTransaction
  attr_reader :current_user

  def initialize(current_user)
    @user = current_user
  end

  def set_index_transaction
    @transaction = Transaction.create(user_id: 0) unless @user
    @transaction = Transaction.where(user_id: @user.id, paid: false).first if @user
    @transaction = Transaction.create(user_id: @user.id) if @user && @transaction.nil?
    @transaction
  end
end
