class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
    @item = Item.find(@promotion.item_id)
  end

  def new
    @promotion = Promotion.new
    @items = Item.all
    @kinds = ["bogo", "bulk"]
  end

  def create
    CreatePromotion.new(promotion_params).create
    redirect_to promotion_path(Promotion.last), notice: 'Promotion was successfully created.'
  end

  def edit
    @promotion = Promotion.find(params[:id])
    @items = Item.all
    @kinds = ["bulk", "bogo"]
  end

  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      redirect_to promotion_path(@promotion)
    else
      redirect_to new_promotion_path(@promotion), status: :unprocessable_entity
    end
  end

  private

  def promotion_params
    params.require(:promotion).permit(:name, :kind, :item_id, :min_quantity, :discount, :active, :promo_price, :original_price)
  end
end
