class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
  end

  def new
    @credit = Credit.new

  def create
    @credit = Credit.new(order_params)   
    if @credit.valid?
      @credit.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  private

  def order_params
    params.require(:credit).permit(:token,:postcode,:prefecture,:address,:building,:phone_number,:order_id)
  end

  def address_params
    params.require(:address).permit(:postcode, :prefecture_id, :city, :address, :building, :phone_number, ).merge(order_id: )
end