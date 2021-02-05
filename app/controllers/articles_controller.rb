class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy] 
  before_action :set_q, only: [:index, :search]
  before_action :various_articles, only: [:index, :search]
  def index
    # @articles = Article.all
    @articles = @q.result
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(params_article)
    if @article.save
      redirect_to root_path, notice: '保存できました'
    else
      flash.now[:errors] = '保存できませんでした'
      render :new
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end
  
  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(params_article)
      redirect_to article_path(@article), notice: '更新に成功しました'
    else
      flash.now = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    @article = current_user.articles.find_by(params[:id])
    if @article.destroy!
      redirect_to root_path, notice: '削除に成功しました'
    end
  end

  def search
    @results = @q.result
  end

  def various_articles
    within_articles = Article.includes(:likes).where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)#今月の投稿
    @ranking_articles =  within_articles.find(Like.group(:article_id).order('count(article_id) desc').limit(4).pluck(:article_id))#投稿の中でいいねが多い記事を3つ
    user_ids = current_user.followings.pluck(:id)#フォローしているユーザーのidのみを取得
    @followings_articles = Article.where(user_id: user_ids).limit(4)#フォローしているユーザーの投稿を4つ取得
    @new_articles = Article.all.order(updated_at: :desc).limit(4)#全ての投稿の最新の投稿を6つ
    tag_ranks = ArticleTag.group(:tag_id).order('count(tag_id) desc').limit(4).pluck(:tag_id)
    @top_tags = Tag.find(tag_ranks)

  end

  private
  def params_article
    params.require(:article).permit(
      :object, 
      :price, 
      :store, 
      :category_id, 
      :content, 
      :rate,
      :image,
      tag_ids: [])
  end

  def set_q
    @q = Article.ransack(params[:q])
  end
end