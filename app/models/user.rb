class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'に全角文字を使用してください' } do
    validates :family_name_kanji
    validates :first_name_kanji
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'に全角カナを使用してください' } do
    validates :family_name_katakana
    validates :first_name_katakana
  end

  validates :nickname, presence: true
  validates :birthday, presence: true
  validates :password, format: { with: /(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,50}/, message: 'は6文字以上の英数字が使えます' }
end
