class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipment_fee
  belongs_to_active_hash :day_to_ship
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name,length: { maximum: 40 }
    validates :description,length: { maximum: 1000 }
    validates :price, inclusion: { in: 300..9999999 },numericality: { only_integer: true }
    validates :image
  end

    validates :category, presence: { message: 'を選択してください' }
    validates :status, presence: { message: 'を選択してください' }
    validates :prefecture, presence: { message: 'を選択してください' }
    validates :shipment_fee, presence: { message: 'を選択してください' }
    validates :day_to_ship, presence: { message: 'を選択してください' }

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :prefecture_id
    validates :shipment_fee_id
    validates :day_to_ship_id
  end
end
