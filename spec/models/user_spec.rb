require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmation,family_name_kanji,first_name_kanji,family_name_katakana,first_name_katakana,birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameが6文字以下で登録できる' do
        @user.nickname = 'aaaaaa'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる,パスワードとパスワード（確認用）、値が一致すれば登録できる' do
        @user.password = '000000a'
        @user.password_confirmation = '000000a'
        expect(@user).to be_valid
      end
      it 'メールアドレスは@を含むと登録できる' do
        @user.email = 'aaa@aaa'
        expect(@user).to be_valid
      end
      it 'family_name_kanji,first_name_kanjiは全角ならば登録できる' do
        @user.family_name_kanji = '笹部'
        @user.first_name_kanji = 'あきひろ'
        expect(@user).to be_valid
      end
      it 'family_name_katakana,first_name_katakanaは全角カナならば登録できる' do
        @user.family_name_katakana = 'ソン'
        @user.first_name_katakana = 'インセイ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Nicknameを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'メールアドレスは@を含まない' do
        @user.email = 'aaaaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが英数混合でないと登録できない' do
        @user.password = '1111111'
        @user.password_confirmation = '1111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上の英数字が使えます')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'family_name_kanjiが空では登録できない' do
        @user.family_name_kanji = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kanjiを入力してください')
      end
      it 'first_name_kanjiが空では登録できない' do
        @user.first_name_kanji = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanjiを入力してください')
      end
      it 'family_name_katakanaが空では登録できない' do
        @user.family_name_katakana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name katakanaを入力してください')
      end
      it 'first_name_katakanaが空では登録できない' do
        @user.first_name_katakana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('First name katakanaを入力してください')
      end
      it 'family_name_kanji,first_name_kanjiは半角ならば登録できない' do
        @user.family_name_kanji = 'sasabe'
        @user.first_name_kanji = 'akihiro'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kanjiに全角文字を使用してください')
      end
      it 'family_name_katakana,first_name_katakanaは半角ならば登録できない' do
        @user.family_name_katakana = 'mori'
        @user.first_name_katakana = 'mori'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name katakanaに全角カナを使用してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Birthdayを入力してください')
      end
    end
  end

  describe 'ユーザーログイン' do
    context 'ログインがうまくいくとき' do
      it 'email、passwordが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context 'ログインがうまくいかない時' do
      it 'email,passwordが空のとき' do
        @user.email = ''
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください', 'パスワードを入力してください', 'パスワードは6文字以上の英数字が使えます', 'パスワード（確認用）とパスワードの入力が一致しません')
      end
    end
  end
end
