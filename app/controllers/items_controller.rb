class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :destroy ,:update]
  before_action :authenticate_user!, only: [:new,:edit,:update]
  before_action :move_to_index, only: [:edit, :update, :delete]

  def index
    @items = Item.includes(:user).order('created_at DESC')
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

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
  
  def move_to_index
    unless user_signed_in? && (current_user.id == @item.user_id)
      redirect_to root_path 
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :prefecture_id, :shipment_fee_id, :day_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end


end
