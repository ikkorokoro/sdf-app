class Apps::OtherUsers::AccountsController < Apps::OtherUsers::ApplicationController

  def show
    @user = User.find(params[:id])
    if current_user == @user
      redirect_to profile_path
    end
  end
end
