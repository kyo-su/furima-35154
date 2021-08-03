require 'rails_helper'

RSpec.describe PurchaseHistoryCustomer, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_history_customer = FactoryBot.build(:purchase_history_customer, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    context '登録内容に問題がない場合' do
      it '全ての値が正しく入力されていれば登録できる' do
        expect(@purchase_history_customer).to be_valid
      end

      it '建物名が空でも保存できる' do
        @purchase_history_customer.building_name = ''
        expect(@purchase_history_customer).to be_valid
      end
    end

    context '登録内容に問題がある場合' do
      it '郵便番号が空だと保存できない' do
        @purchase_history_customer.post_number = ''
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Post number can't be blank")
      end

      it '市区町村が空だと保存できない' do
        @purchase_history_customer.municipality = ''
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が空だと保存できない' do
        @purchase_history_customer.address = ''
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと保存できない' do
        @purchase_history_customer.phone_number = ''
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Phone number can't be blank")
      end

      it '郵便番号は半角数字と半角のハイフンを含んだ形式でないと保存できない（ハイフンなしの場合）' do
        @purchase_history_customer.post_number = '11111111'
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
      end

      it '郵便番号は半角数字と半角のハイフンを含んだ形式でないと保存できない（ハイフン含む半角英字の場合）' do
        @purchase_history_customer.post_number = 'aaa-aaaa'
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
      end

      it '郵便番号は半角数字と半角のハイフンを含んだ形式でないと保存できない（ハイフン含む半角数字英字混合の場合）' do
        @purchase_history_customer.post_number = 'aaa-aaaa'
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Post number is invalid. Include hyphen(-)")
      end

      it '都道府県に1が選択された場合は保存できない' do
        @purchase_history_customer.prefecture_id = 1
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '電話番号は半角数字でないと保存できない（全角の場合）' do
        @purchase_history_customer.phone_number = 'aaaaaaaaaaa'
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Phone number is not a number")
      end

      it '電話番号は半角数字でないと保存できない（半角英字の場合）' do
        @purchase_history_customer.phone_number = 'aaaaaaaaaaa'
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Phone number is not a number")
      end

      it '電話番号は半角数字でないと保存できない（半角英数字混合の場合）' do
        @purchase_history_customer.phone_number = 'aaa11111111'
        @purchase_history_customer.valid?
        expect(@purchase_history_customer.errors.full_messages).to include("Phone number is not a number")
      end
      
    end
  end
end
