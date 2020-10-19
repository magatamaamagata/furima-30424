require 'rails_helper'

RSpec.describe OrderCredits, type: :model do
  describe '購入者情報の保存' do
    before do
      @order_credits = FactoryBot.build(:order_credits)
    end
    
    context "購入できる時" do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_credits).to be_valid
      end
    end

    context "購入に失敗する時" do
      it 'postcodeが空だと保存できないこと' do
        @order_credits.postcode = nil
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Postcodeを入力してください")
      end
      it 'postcodeにハイフンがないと保存できないこと' do
        @order_credits.postcode = "1111111"
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Postcodeハイフンを含めてください")
      end
      it 'postcodeが7桁でないと保存できないこと' do
        @order_credits.postcode = "111-111"
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Postcodeハイフンを含めてください")
      end
      it 'prefecture_idが空だと保存できないこと' do
        @order_credits.prefecture_id = nil
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Prefectureは数値で入力してください")
      end
      it 'prefecture_idが1だと保存できないこと' do
        @order_credits.prefecture_id = 1
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Prefectureは1以外の値にしてください")
      end
      it 'cityが空だと保存できないこと' do
        @order_credits.city = nil
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Cityを入力してください")
      end
      it 'addressが空だと保存できないこと' do
        @order_credits.address = nil
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Addressを入力してください")
      end
      it 'buildingは空でも保存できること' do
        @order_credits.building = nil
        expect(@order_credits).to be_valid
      end
      it 'phone_numberは空だと保存できないこと' do
        @order_credits.phone_number = nil
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Phone numberを入力してください")
      end
      it 'phone_numberは１１桁以上だと保存できないこと' do
        @order_credits.phone_number = "090090090090"
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Phone numberは11文字以内で入力してください")
      end
      it 'phone_numberはハイフンがあると保存できないこと' do
        @order_credits.phone_number = "090-090-090"
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Phone numberハイフンを消してください")
      end
      it 'tokenが空だと保存できないこと' do
        @order_credits.token = nil
        @order_credits.valid?
        expect(@order_credits.errors.full_messages).to include("Tokenを入力してください")
      end

    end
  end
end