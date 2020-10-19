class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]
  before_action :set_item

  def index
    @order_credit = OrderCredits.new
  end

  def create
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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.order
  end

  def order_params
    params.require(:order_credits).permit(:token, :postcode, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, token: params[:token], item_id: @item.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
