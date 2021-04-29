require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:article) { create(:article) }
  let!(:articles) { create_list(:article, 3, user: user) }
  describe '#index' do

    it '正常にアクセスできる' do
      get articles_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#new' do
    context 'ログインしていないとき' do

      it 'ログインページにリダイレクトされる' do
        get new_article_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
  end

  context 'ログインしている時' do
    before do
      sign_in user#rapecではsign_in が使えないためrails_helper.rb に記載
    end

    it '正常にアクセスできる' do
      get new_article_path
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    context 'ログインしていない時' do

      it 'ログイン画面に遷移する' do
        article_params = attributes_for(:article)#ハッシュを作成してくれる
        post articles_path({article: article_params})#article: {:title, :content}を作成した
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ログインしている時' do
      before do
        sign_in user
      end

      it '記事を保存できる' do
        article_params = attributes_for(:article)#ハッシュを作成してくれる
        post articles_path({article: article_params})#article: {:title, :content}を作成した
        expect(response).to have_http_status(200)
        expect(Article.last.object).to eq(article_params[:object])
        expect(Article.last.price).to eq(article_params[:price])
        expect(Article.last.store).to eq(article_params[:store])
        expect(Article.last.content).to eq(article_params[:content])
        expect(Article.last.rate).to eq(article_params[:rate])
      end
    end
  end

  describe '#show' do
    context 'ログインしていない時' do

      it 'ログイン画面に遷移する' do
        get article_path(article)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ログインしている時' do
      before do
        sign_in user
      end

      it '投稿詳細画面に推移する' do
        get article_path(article)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#edit' do
    context 'ログインしていない時' do
      it 'ログインページにリダイレクトされること' do
        get edit_article_path(article)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to user_session_path
      end
    end
    context 'ログインしている時' do
      before do
        sign_in user
      end
      it '投稿者だと正常にアクセスできる' do
        article = create(:article, user: user)
        get edit_article_path(article)
        expect(response).to have_http_status(200)
      end

    end
  end
end
