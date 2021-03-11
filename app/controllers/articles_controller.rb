class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy, :search]
  before_action :set_q, only: [:index, :search]

  def index
    @ranking_articles = Article.with_attached_image.includes(:tags, image_attachment: :blob, user: [profile: :avatar_attachment]).find(Like.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))#投稿の中でいいねが多い記事を3つ
    category_ranks = Article.group(:category_id).order('count(category_id) desc').limit(5).pluck(:category_id)#投稿の多いカテゴリ上位のidを５つ取得
    @top_categorys = Category.find(category_ranks)
    top_one_category = category_ranks.first#一番初めのカテゴリ(一番人気のカテゴリ)のidを取得
    @top_category_articles = Article.with_attached_image.includes(:tags, user: [profile: :avatar_attachment]).where(category_id: top_one_category).limit(3)#一番人気のカテゴリの投稿を全て取得
    tag_ranks = ArticleTag.group(:tag_id).order('count(tag_id) desc').limit(5).pluck(:tag_id)
    @top_tags = Tag.find(tag_ranks)
    @new_articles = Article.with_attached_image.includes(:tags, user: [profile: :avatar_attachment]).order(updated_at: :desc).limit(10)#全ての投稿の最新の投稿
  end

  def show
    @article = Article.find(params[:id])
    @senjins = RakutenWebService::Ichiba::Item.search(
      keyword: @article.object,
      shopCode: 'shop-senjin',
      sort: '-reviewAverage',
      hits: 5)
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
    @q = Article.includes(:tags, user: [profile: :avatar_attachment]).with_attached_image.ransack(params[:q])#新着順に並べ替える
  end
end
