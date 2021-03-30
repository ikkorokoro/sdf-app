class Api::LikesController < Api::ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :destroy]
  before_action :set_article, only: [:show, :create, :destroy]

  def show
    has_liked = current_user.has_liked?(@article)
    likes_count = @article.likes.count
    render json: { hasLiked: has_liked, likesCount: likes_count }
  end

  def create
    @article.likes.create!(user_id: current_user.id)
    #通知作成
    @article.create_notification_like!(current_user)
    likes_count = @article.likes.count
    render json: { status: 'ok', likesCount: likes_count }
  end

  def destroy
    like = @article.likes.find_by!(user_id: current_user.id)
    like.destroy
    likes_count = article.likes.count
    render json: { status: 'ok', likesCount: likes_count }
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
