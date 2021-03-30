require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  context '全てのカラムが入力されている場合' do

    it 'userを登録できる' do
      expect(user).to be_valid
    end
  end

  describe '存在性の検証' do
    context 'accountが入力されていない場合' do
      let!(:user) { build(:user, account: '') }

      before do
        user.save
      end

      it '登録できない' do
        expect(user.errors.messages[:account][0]).to eq('を入力してください')
      end
    end

    context 'emailが入力されていない場合' do
      let!(:user) { build(:user, email: '') }

      before do
        user.save
      end

      it '登録できない' do
        expect(user.errors.messages[:email][0]).to eq('を入力してください')
      end
    end

    context 'passwordが入力されていない場合' do
      let!(:user) { build(:user, password: '') }

      before do
        user.save
      end

      it '登録できない' do
        expect(user.errors.messages[:password][0]).to eq('を入力してください')
      end
    end
  end

  describe '一意性の検証' do
    context '重複したemailアドレスが登録される場合' do
      let!(:user) { build(:user) }
      let!(:dupulicate_user) { build(:user, email: user.email) }
      before do
        user.save
        dupulicate_user.save
      end

      it '登録できない' do
        expect(dupulicate_user.errors.messages[:email][0]).to eq('はすでに存在します')
      end
    end
  end

  describe '文字数の検証' do
    context 'email文字数が255以上の場合' do
      let!(:user) { build(:user, email: 'a' * 244 + '@example.com') }

      before do
        user.save
      end

      it '登録できない' do
        expect(user.errors.messages[:email][0]).to eq('は255文字以内で入力してください')
      end
    end

    context 'email文字数が255以内の場合' do
      let!(:user) { build(:user, email: 'a' * 243 + '@example.com') }

      it '登録できる' do
        expect(user).to be_valid
      end

    context 'password文字数が5文字以内の場合' do
      let!(:user) { build(:user, password: 'a' * 5) }

      before do
        user.save
      end

      it '登録できない' do
        expect(user.errors.messages[:password][0]).to eq('は6文字以上で入力してください')
      end
    end

    context 'password文字数が6文字以上の場合' do
      let!(:user) { build(:user) }

      it '登録できる' do
        expect(user).to be_valid
      end
    end
  end
end

  describe 'フォーマットの検証' do
    context '正しいフォーマットの場合' do
      let!(:user) { build(:user, email: 'test@example.com') }

      it '登録できる' do
        expect(user).to be_valid
      end
    end

    context '不正なフォーマットの場合' do
      let!(:user) { build(:user, email: 'test@example,com') }

      before do
        user.save
      end

      it '登録できない' do
        expect(user.errors.messages[:email][0]).to eq('は不正な値です')
      end
    end
  end

  describe 'パスワードの検証' do
    context 'パスワードと確認用パスワードが間違っている場合' do
      let!(:user) { build(:user, password_confirmation: 'pass') }

      before do
        user.save
      end

      it '登録できない' do
      expect(user.errors.messages[:password_confirmation][0]).to eq('とパスワードの入力が一致しません')
      end
    end
  end
  describe '削除依存性の検証' do
    context '記事を削除した場合' do
      let!(:article) { create(:article, user: user, category: category) }
      let!(:like) { create(:like, user: user, article: article) }

      it '紐づくメニュー記事も削除される' do
        expect{user.destroy}.to change(user.articles, :count).by(-1)
      end

      it '紐づくメニューフォローも削除される' do
        expect{user.destroy}.to change(user.likes, :count).by(-1)
      end
    end
  end
end
