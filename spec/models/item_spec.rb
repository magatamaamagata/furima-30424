require 'rails_helper'

describe Item do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品する' do
    context '出品がうまくいくとき' do
      it '画像があり、全ての欄が埋まっていれば存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it '価格の範囲が、¥300~¥9,999,999の間である' do
        @item.price = '9999998'
        expect(@item).to be_valid
      end
      it '商品名が、40字以内である' do
        @item.name = 'お芋です'
        expect(@item).to be_valid
      end
      it '商品の説明が、1000文字以内である' do
        @item.description = 'わははははははははははははははははははははは'
        expect(@item).to be_valid
      end
    end

    context '出品がうまくいかないとき' do
      it '出品画像が空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Imageを入力してください')
      end
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Nameを入力してください')
      end
      it '商品名が40字以上では登録できない' do
        @item.name = Faker::Lorem.sentence(word_count: 50)
        @item.valid?
        expect(@item.errors.full_messages).to include('Nameは40文字以内で入力してください')
      end
      it '商品の説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Descriptionを入力してください')
      end
      it '商品の説明が1000文字以上だと登録できない' do
        @item.description = Faker::Lorem.sentence(word_count: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include('Descriptionは1000文字以内で入力してください')
      end
      it 'カテゴリーが非選択では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Categoryは1以外の値にしてください')
      end
      it '商品の状態が非選択では登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Statusは1以外の値にしてください')
      end
      it '配送料の負担が非選択では登録できない' do
        @item.shipment_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipment feeは1以外の値にしてください')
      end
      it '発送元の地域が非選択では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefectureは1以外の値にしてください')
      end
      it '発送までの日数が非選択では登録できない' do
        @item.day_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Day to shipは1以外の値にしてください')
      end
      it '販売価格が299円以下だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは一覧にありません')
      end
      it '販売価格が10000000円以上だと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは一覧にありません')
      end
      it '販売価格が全角数字だと登録できない' do
        @item.price = '４４４４４'
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは一覧にありません', 'Priceは数値で入力してください')
      end
      it '販売価格が全角文字だと登録できない' do
        @item.price = '百円'
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは一覧にありません', 'Priceは数値で入力してください')
      end
    end
  end
end
