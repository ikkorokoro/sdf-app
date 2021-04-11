require 'rails_helper'
RSpec.describe 'App::OtherUser::Account', type: :request do
  let!(:user) {create(:user)}
  let!(:other_user) {create(:user)}
  describe 'GET /api/likes' do
    context 'ログインしている場合' do 
      before do
        sign_in user
      end
      it '正常にアクセスできる' do
        get account_path(id: other_user)
        expect(response).to have_http_status(200)
      end
      it '自分のaccount_pathにリクエストが来た場合、profile_pathにリダイレクト' do
        get account_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to profile_path
      end
    end
    context 'ログインしていない場合' do 
      it 'ログインページへリダイレクト' do
        get account_path(id: other_user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
  end
end