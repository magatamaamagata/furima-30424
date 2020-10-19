class OrderCredits
  include ActiveModel::Model

  attr_accessor :token, :postcode, :prefecture_id, :city, :address, :building, :phone_number, :order_id, :user_id, :item_id



  with_options presence: true do
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "ハイフンを含めてください"}
    validates :city
    validates :address
    validates :phone_number,length: { maximum: 11 }, format: {with: /\A\d{,11}\z/, message: "ハイフンを消してください"}
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1 } 




  def save
    order = Order.create( user_id: user_id, item_id: item_id )
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, address: address, building: building,phone_number: phone_number, order_id: order.id )
  end

end