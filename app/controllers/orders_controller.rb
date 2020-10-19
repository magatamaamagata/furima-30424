class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @order_credit = OrderCredits.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @order_credit = OrderCredits.new(order_params)
      if @order_credit.valid?
        pay_item
        @order_credit.save
        redirect_to root_path
      else
        render action: :index
      end
  end

  private
  def move_to_index
    item = Item.find(params[:item_id])
    if current_user.id == item.user_id
      redirect_to root_path
    end
  end

  def order_params
    params.require( :order_credits ).permit( :token, :postcode, :prefecture_id, :city, :address, :building, :phone_number).merge( user_id: current_user.id, token: params[:token],item_id: @item.id)
  end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end