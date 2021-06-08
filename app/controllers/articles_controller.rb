class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy]
  before_action :set_article, only: [:edit, :update]

  def index
    #投稿の中でいいねが多い記事を3つ
    @three_articles_with_many_likes = Article.find_three_articles_with_many_likes
    #投稿の多いカテゴリ上位５つのidを取得
    five_categorys_id_with_many_articles = Article.group_five_categorys_id_with_many_articles
    #カテゴリ上位５つのレコード取得
    @five_categorys = Category.find(five_categorys_id_with_many_articles)
    #一番初めのカテゴリ(一番人気のカテゴリ)を取得
    @top_category = @five_categorys.first
    #一番人気のカテゴリの投稿を全て取得
    @top_category_all_articles = Article.where_top_category_all_articles(@top_category)
    #投稿の多いタグ上位５つのid取得
    five_tags_id_with_many_article_tags = ArticleTag.group_five_tags_id_with_many_article_tags
    #タグ上位５つのレコード取得
    @five_tags = Tag.find(five_tags_id_with_many_article_tags)
    #全ての投稿の最新の投稿
    @updated_at_desc_articles = Article.updated_at_desc_articles
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
end
