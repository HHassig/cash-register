class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
    @user = current_user
  end

  def show
    @promotion = Promotion.find(params[:id])
    @item = Item.find(@promotion.item_id)
  end

  def new
    @user = current_user
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to promotion_path(@promotion), notice: 'Promotion was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      redirect_to promotion_path(@promotion)
    else
      redirect_to new_promotion_path(@promotion), status: :unprocessable_entity
    end
  end

  def destroy
    @promotion = Promotion.find(params[:id])
    # raise
    @promotion.destroy!
    redirect_to promotions_path, notice: 'Promotion was successfully destroyed.', status: :see_other
  end

  private

  def promotion_params
    params.require(:promotion).permit(:name, :kind, :item_id, :min_quantity, :discount)
  end
end
