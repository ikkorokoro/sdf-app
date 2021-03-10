class Api::CommentsController < Api::ApplicationController
def index
  article = Article.find(params[:article_id])
  comments = article.comments
  render json: comments
end

def create
  article = Article.find(params[:article_id])
  comment = article.comments.build(comment_params)
  comment.save!
  #通知作成
  article.create_notification_comment!(current_user, comment.id)
  render json: comment
end

def destroy
  @article = Article.find(params[:article_id])
  arricle = article.comments.find_by(user_id: current_user.id)
  if article.destroy!
    redirect_to article_path(@article), notice: '削除に成功しました'
    # render json:  { status: 'ok' }
  end
end
private
def comment_params
  params.require(:comment).permit(:content).merge(user_id: current_user.id)
end
end
