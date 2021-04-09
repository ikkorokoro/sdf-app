require 'rails_helper'
RSpec.describe 'App::OtherUser::Follow', type: :request do
  let!(:user) {create(:user)}
  let!(:other_user) {create(:user)}

  describe 'POST /accounts/follows' do
    context 'ログインしている場合' do 
      before do
        sign_in user
      end
      it '正常にアクセスできる' do
        post account_follows_path({account_id: other_user})
        expect(response).to have_http_status(200)
      end
      it 'レスポンスとしてjsonでokが返ってくる' do
          post account_follows_path({account_id: other_user})
          expect(response).to have_http_status(200)
          body = JSON.parse(response.body)
          expect(body['status']).to eq 'ok'
      end
      it 'レスポンスとしてjsonフォロワーの数が返ってくる' do
          post account_follows_path({account_id: other_user})
          expect(response).to have_http_status(200)
          body = JSON.parse(response.body)
          follower_count = other_user.followers.count
          expect(body['followerCount']).to eq follower_count
      end
    end
  end
end