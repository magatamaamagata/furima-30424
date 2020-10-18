class Credit
  include ActiveModel::Model
  attr_accessor :token, :postcode, :prefecture_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :building
    validates :phone_number
  end

  def save
    # ユーザーの情報を保存し、「user」という変数に入れている
    order = Order.create(user_id: user.id, item_id: item.id)
    # 住所の情報を保存
    Address.create(token: token,postcode: postcode, prefecture: prefecture, city: city, address: address, building: building,phone_number: phone_number, order_id: order.id)
  end

end