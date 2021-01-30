class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy] 
  before_action :set_q, only: [:index, :search]
  def index
    @articles = Article.all
    within_articles = Article.includes(:likes).where(created_at: Time.current.ago(24.hours)..Time.current)
    @ranking_articles =  within_articles.find(Like.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
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

  private
  def params_article
    params.require(:article).permit(:object, :price, :store, :category, :content, :rate, :image)
  end

  def set_q
    @q = Article.ransack(params[:q])
  end
end