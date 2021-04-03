class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy, :search]
  before_action :set_q, only: [:index, :search]
  before_action :set_article, only: [:edit, :update]

  def index
    #投稿の中でいいねが多い記事を3つ
    @three_articles_with_many_likes = Article.with_attached_image.includes(:tags, user: [profile: [avatar_attachment: :blob]]).find(Like.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
    #投稿の多いカテゴリ上位５つのidを取得
    five_categorys_id_with_many_articles = Article.group(:category_id).order('count(category_id) desc').limit(5).pluck(:category_id)
    #カテゴリ上位５つのレコード取得
    @five_categorys = Category.find(five_categorys_id_with_many_articles)
    #一番初めのカテゴリ(一番人気のカテゴリ)を取得
    @top_category = @five_categorys.first
    #一番人気のカテゴリの投稿を全て取得
    @top_category_articles = Article.with_attached_image.includes(:tags, user: [profile: [avatar_attachment: :blob]]).where(category_id: @top_category).limit(3)
    #投稿の多いタグ上位５つのid取得
    five_tags_id_with_many_articles_id = ArticleTag.group(:tag_id).order('count(tag_id) desc').limit(5).pluck(:tag_id)
    #タグ上位５つのレコード取得
    @five_tags = Tag.find(five_tags_id_with_many_articles_id)
    #全ての投稿の最新の投稿
    @new_articles_with_all_articles = Article.with_attached_image.includes(:tags, user: [profile: [avatar_attachment: :blob]]).order(updated_at: :desc).limit(16)
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
  end

  def update
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
  def set_article
    @article = current_user.articles.find(params[:id])
  end

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
    @q = Article.with_attached_image.includes(:tags, user: [profile: [avatar_attachment: :blob]]).ransack(params[:q])
  end
end
