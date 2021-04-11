require 'rails_helper'

RSpec.describe 'Api::Informations', type: :request do
  let!(:user) {create(:user)}
  let!(:other_user) {create(:user)}
  let!(:article) {create(:article, user: user)}
  let!(:followed_user) {create(:relationship, follower: user, following: other_user)}
  describe 'GET /api/accounts/:account_id/informations' do
    context 'ログインしている場合' do 
      before do
        sign_in user
      end
      it '正常にアクセスできる' do
        get api_informations_path(account_id: other_user)
        expect(response).to have_http_status(200)
      end
      it 'フォローしてたらtrue' do
        get api_informations_path(account_id: other_user)
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['hasFollow']).to eq true
      end
      it 'フォローしていない場合false' do
        user.unfollow!(other_user)
        get api_informations_path(account_id: other_user)
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['hasFollow']).to eq false
      end
      it 'フォロワーの数を返す' do
        get api_informations_path(account_id: other_user)
        expect(response).to have_http_status(200)
        follower_counts = other_user.followers.count
        body = JSON.parse(response.body)
        expect(body['followersCount']).to eq follower_counts
      end
      it 'フォローの数を返す' do
        get api_informations_path(account_id: other_user)
        expect(response).to have_http_status(200)
        following_counts = other_user.followings.count
        body = JSON.parse(response.body)
        expect(body['followingsCount']).to eq following_counts
      end
    end
  end
end