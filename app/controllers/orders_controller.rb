class OrdersController < ApplicationController
  def index
    @order_credit = OrderCredit.new
    @item = Item.find(params[:item_id])
    
  end

  def create
    @order_credit = OrderCredit.new(order_params)   
    if @order_credit.valid?
      pay_item
      @order_credit.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_credit).permit(:token,:postcode,:prefecture,:city,:address,:building,:phone_number)
  end

  def pay_item
    Payjp.api_key = ""  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: order_params[:price],  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end