require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  describe OrderForm do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
      sleep 0.1 
    end

    describe '商品購入機能' do
      context '購入する商品の保存ができる時' do
        it '全ての項目が必要条件を満たし、かつ存在する' do
          expect(@order_form).to be_valid
        end

        it 'tokenが入っている' do
          @order_form.token = 'tok_abcdefghijk1111111111111111111111'
          expect(@order_form).to be_valid
        end

        it '郵便番号が正しく入力されている' do
          @order_form.postal_code = '321-7654'
          expect(@order_form).to be_valid
        end

        it '都道府県が選択されている' do
          @order_form.prefecture_id = 3
          expect(@order_form).to be_valid
        end

        it '市区町村が記述されている' do
          @order_form.city = '川崎市'
          expect(@order_form).to be_valid
        end

        it '番地が記述されている' do
          @order_form.addresses = '中央1-1'
          expect(@order_form).to be_valid
        end

        it '建物名が未入力でも保存される' do
          @order_form.building = ''
          expect(@order_form).to be_valid
        end

        it '電話番号が記述されている' do
          @order_form.phone_number = '09011112222'
          expect(@order_form).to be_valid
        end
      end

      context '購入する商品の登録・保存ができない時' do
        it 'tokenが空の状態' do
          @order_form.token = ''
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Token can't be blank")
        end

        it '郵便番号が記載されていない' do
          @order_form.postal_code = ''
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid')
        end

        it '郵便番号にハイフンが含まれていない' do
          @order_form.postal_code = '1234567'
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include('Postal code is invalid')
        end

        it '郵便番号のハイフン位置が適切ではない' do
          @order_form.postal_code = '1234-567'
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include('Postal code is invalid')
        end

        it '都道府県が選択されていない' do
          @order_form.prefecture_id = 1
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include('Prefecture must be other than 1')
        end

        it '市区町村が記述されていない' do
          @order_form.city = ''
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("City can't be blank")
        end

        it '番地が記述されていない' do
          @order_form.addresses = ''
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Addresses can't be blank")
        end

        it '電話番号が記述されていない' do
          @order_form.phone_number = ''
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
        end

        it '電話番号の桁が11桁より多い' do
          @order_form.phone_number = '090123456789'
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
        end

        it '電話番号に全角数字が入力されている' do
          @order_form.phone_number = '０９０１２３４５６７８'
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include('Phone number is invalid')
        end

        it '電話番号にハイフンが含まれている' do
          @order_form.phone_number = '090-123-456'
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include('Phone number is invalid')
        end

        it '英数混合では登録できないこと' do
          @order_form.phone_number = '090123aaaa'
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include('Phone number is invalid')
        end

        it 'ユーザーidが空' do
          @order_form.user_id = ''
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("User can't be blank")
        end

        it 'アイテムidが空' do
          @order_form.item_id = ''
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Item can't be blank")
        end
      end
    end
  end
end
