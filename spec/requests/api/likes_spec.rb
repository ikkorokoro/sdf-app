require 'rails_helper'

RSpec.describe 'Api::Likes', type: :request do
  let!(:user) {create(:user)}
  let!(:article) {create(:article, user: user)}
  let!(:like) {create(:like, user: user, article: article)}
  describe 'GET /api/likes' do
    context 'ログインしている場合' do 
      before do
        sign_in user
      end

      it 'いいねしてたらtrueとなる' do
        get api_like_path(article_id: article.id)
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['hasLiked']).to eq true
      end

      it 'いいねしていない時falseとなる' do
        like.destroy!
        get api_like_path(article_id: article.id)
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['hasLiked']).to eq false
      end

      it 'いいねの数が帰ってくる' do
        get api_like_path(article_id: article.id)
        expect(response).to have_http_status(200)
        likescount = article.likes.count
        body = JSON.parse(response.body)
        expect(body['likesCount']).to eq likescount
      end
    end
    context 'ログインしていない場合' do 
      it 'ログイン画面にリダイレクト' do
        get api_like_path(article_id: article.id)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
  end
end
