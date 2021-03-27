class Api::CommentsController < Api::ApplicationController
  before_action: :set_article, only: [:index, :create]
  
  def index
    comments = article.comments
    render json: comments
  end

  def create
    comment = article.comments.build(comment_params)
    comment.save!
    #通知作成
    article.create_notification_comment!(current_user, comment.id)
    render json: comment
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def set_article
    article = Article.find(params[:article_id])
  end
end
