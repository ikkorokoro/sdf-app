# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account                :string(191)      default(""), not null
#  email                  :string(191)      default(""), not null
#  encrypted_password     :string(191)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(191)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
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

  describe 'フォロー、アンフォローの検証' do
    context 'フォローした場合' do
      let!(:user) { create(:user) }
      let!(:other_user) { create(:user) }
      before do
        user.follow!(other_user)
      end
      it 'フォロー状態になる' do
        expect(other_user.followers).to include user
        expect(user.has_followed?(other_user)).to eq true
      end
      it 'アンフォロー状態になる' do
        user.unfollow!(other_user)
        expect(user.has_followed?(other_user)).to eq false
      end
    end
  end

  describe 'いいね、いいね解除を検証する場合' do
    context 'いいねしていない状態の場合' do
      let!(:article) { create(:article) }
      it '無効な状態である' do
        expect(user.has_liked?(article)).to eq false
      end
    end

    context 'いいねした状態の場合' do
      let!(:article) { create(:article) }

      before do
        user.likes.create(article_id: article.id)
      end

      it 'いいね状態であること' do
        expect(user.has_liked?(article)).to eq true
      end

      it 'unlikeするといいねが無効になる' do
        like = user.likes.find_by!(article_id: article.id)
        like.destroy
        expect(user.has_liked?(article)).to eq false
      end
    end
  end
  describe '削除の検証' do
    context '記事がが削除された場合' do
      let!(:other_user) { create(:user) }
      let!(:article) { create(:article, user: user, category: category ) }
      let!(:comment) { create(:comment, user: user, article: article) }
      let!(:like) { create(:like, user: user, article: article) }
      let!(:notification) { create(:notification, article_id: article.id, visited_id: user.id, visiter_id: other_user.id)}
      it '正常に削除される' do
        expect{user.destroy}.to change{User.count}.by(-1)
      end
      it '紐ずく投稿も削除される' do
        expect{user.destroy}.to change{user.articles.count}.by(-1)
      end
      it '紐ずくいいねも削除される' do
        expect{user.destroy}.to change{user.likes.count}.by(-1)
      end
      it '紐ずくコメントも削除される' do
        expect{user.destroy}.to change{user.comments.count}.by(-1)
      end
      it '紐ずくフォローも削除される' do
        user.follow!(other_user)
        expect{user.destroy}.to change{user.followings.count}.by(-1)
      end
      it '紐ずくフォローも削除される' do
        user.follow!(other_user)
        expect{user.destroy}.to change{other_user.followers.count}.by(-1)
      end
      it '紐ずく自分の通知も削除される' do
        expect{user.destroy}.to change{user.passive_notifications.count}.by(-1)
      end
      it '紐ずくプロフィールも削除される' do
        expect{user.destroy}.to change{Profile.count}.by(-1)
      end
    end
  end
end
