class TimelinesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    user_ids = current_user.followings.pluck(:id)
    @articles = Article.where(user_id: user_ids)
    within_articles = Article.includes(:likes).where(created_at: Time.current.ago(24.hours)..Time.current)
    @ranking_articles =  within_articles.find(Like.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end
  end