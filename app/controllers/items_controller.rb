class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
      @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :prefecture_id, :shipment_fee_id, :day_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end
end
