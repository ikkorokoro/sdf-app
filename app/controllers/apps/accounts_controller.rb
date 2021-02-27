class Apps::AccountsController < Apps::ApplicationController

  def show
    @user = User.find(params[:id])
      if current_user == @user
        redirect_to profile_path
    end
    @articles = @user.articles
  end
end
