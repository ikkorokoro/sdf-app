class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy, :search] 
  before_action :set_q, only: [:index, :search]

  def index
    month_articles = Article.includes(:likes).where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)#今月の投稿
    @ranking_articles = month_articles.find(Like.group(:article_id).order('count(article_id) desc').limit(4).pluck(:article_id))#投稿の中でいいねが多い記事を3つ
    category_ranks = Article.group(:category_id).order('count(category_id) desc').limit(5).pluck(:category_id)#投稿の多いカテゴリ上位のidを５つ取得
    @top_categorys = Category.find(category_ranks)
    top_one_category = category_ranks.first#一番初めのカテゴリ(一番人気のカテゴリ)のidを取得
    @top_category_articles = Article.where(category_id: top_one_category).limit(4)#一番人気のカテゴリの投稿を全て取得
    tag_ranks = ArticleTag.group(:tag_id).order('count(tag_id) desc').limit(5).pluck(:tag_id)
    @top_tags = Tag.find(tag_ranks)
    @new_articles = Article.all.order(updated_at: :desc).limit(8)#全ての投稿の最新の投稿
  end

  def show
    @article = Article.find(params[:id])
    @cate_articles = Article.where(category_id: @article.category.id).order(updated_at: :desc).limit(5) 
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
    @results = @q.result.page(params[:page]).per(10)
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