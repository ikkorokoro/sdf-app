class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] 
  
  def index
    @articles = Article.all
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
      redirect_to article_path(@article), notice: '保存できました'
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

  private
  def params_article
    params.require(:article).permit(:object, :price, :store, :category, :content)
  end
end