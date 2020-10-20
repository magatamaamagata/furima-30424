class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit,:update]
  before_action :move_to_index, only: [:edit, :update]

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def delete
  end

  private
  
  def move_to_index
    @item = Item.find(params[:id])
    unless user_signed_in? && (current_user.id == @item.user_id)
      redirect_to root_path 
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :prefecture_id, :shipment_fee_id, :day_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end


end
