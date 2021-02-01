class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :destroy]
  def show
    article = Article.find(params[:article_id])
    like_status = current_user.has_liked?(article)
    likes_count = article.likes.count
    render json: { hasLiked: like_status, likesCount: likes_count }
  end

  def create
    @article = Article.find(params[:article_id])
    @article.likes.create!(user_id: current_user.id)
    #通知作成
    @article.create_notification_like!(current_user)
    likes_count = @article.likes.count
    render json: { status: 'ok', likesCount: likes_count }

  end

  def destroy
    article = Article.find(params[:article_id])
    like = article.likes.find_by!(user_id: current_user.id)
    like.destroy
    likes_count = article.likes.count
    render json: { status: 'ok', likesCount: likes_count }
  end
end