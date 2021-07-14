require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザーの新規登録' do
    context '新規登録できるとき' do
      it 'email、password、password_confirmation、nickname、family_name_kanji、first_name_kanji、family_name_kana、first_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = 'aaa000'
        @user.password_confirmation = 'aaa000'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'family_name_kanjiが空では登録できない' do
        @user.family_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kanji can't be blank")
      end

      it 'first_name_kanjiが空では登録できない' do
        @user.first_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji can't be blank")
      end

      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password = '000aaa'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在すれば登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailが@を含めてないと登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '000aa'
        @user.password_confirmation = '000aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが英数字混合でないと登録できない（数字のみの場合）' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordが英数字混合でないと登録できない（英字のみの場合）' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'パスワードが全角英数字混合だと登録できないこと（数字が全角の場合）' do
        @user.password = 'aaa１１１'
        @user.password_confirmation = 'aaa１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'パスワードが全角英数字混合だと登録できないこと（英字が全角の場合）' do
        @user.password = 'ＡＡＡ111'
        @user.password_confirmation = 'aaa１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'ユーザー本名（名字）は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.family_name_kanji = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kanji is invalid. Input full-width characters')
      end

      it 'ユーザー本名（名前）は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name_kanji = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanji is invalid. Input full-width characters')
      end

      it 'ユーザー本名（名字）のフリガナは、全角（カタカナ）でないと登録できない（半角の場合）' do
        @user.family_name_kana = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana is invalid. Input full-width katakana characters')
      end

      it 'ユーザー本名（名字）のフリガナは、全角（カタカナ）でないと登録できない（全角（カタカナ）以外の場合）' do
        @user.family_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana is invalid. Input full-width katakana characters')
      end

      it 'ユーザー本名（名前）のフリガナは、全角（カタカナ）でないと登録できない（半角の場合）' do
        @user.first_name_kana = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end

      it 'ユーザー本名（名前）のフリガナは、全角（カタカナ）でないと登録できない（全角（カタカナ）以外の場合）' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end
    end
  end
end
