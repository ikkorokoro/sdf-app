class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  def show
    article = Article.find(params[:article_id])
    like_status = current_user.has_liked?(article)
    likes_count = article.likes.count
    render json: { hasLiked: like_status, likesCount: likes_count }
  end

  def create
    article = Article.find(params[:article_id])
    article.likes.create!(user_id: current_user.id)
    render json: {status: 'ok'}
  end

  def destroy
    article = Article.find(params[:article_id])
    like = article.likes.find_by!(user_id: current_user.id)
    like.destroy
    render json: {status: 'ok'}
  end
end