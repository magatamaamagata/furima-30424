class OrderCredit
  include ActiveModel::Model
  attr_accessor :token, :postcode, :prefecture, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "ハイフンを含めてください"}
    validates :prefecture, numericality: { other_than: 1, message: "を選択してください" }
    validates :city
    validates :address
    validates :phone_number,length: { maximum: 40 }
    validates :token
  end

  def save
    user = current_user
    Item.create(price: price)
    order = Order.create( user_id: user.id, item_id: item.id,token: token )
    Address.create(postcode: postcode, prefecture: prefecture, city: city, address: address, building: building,phone_number: phone_number, order_id: order.id )
  end

end