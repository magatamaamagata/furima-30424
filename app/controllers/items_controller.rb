class ItemsController < ApplicationController
  def index
  end

  def new
    if user_signed_in?
      @item = Item.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

def item_params
  params.require(:item).permit(:name,:description,:category_id,:status_id,:prefecture_id,:shipment_fee_id,:day_to_ship_id,:price,:image).merge(user_id: current_user.id)
end

end

