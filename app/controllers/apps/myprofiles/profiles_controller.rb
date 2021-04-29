class Apps::Myprofiles::ProfilesController < Apps::Myprofiles::ApplicationController
  before_action :set_article, only: [:edit, :update]

  def show
    @profile = current_user.profile
    @articles = current_user.articles.with_attached_image.includes(:tags)
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: 'プロフィールを更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render 'edit'
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:avatar, :name, :affiliation, :introduction)
  end

  def set_article
    @profile = current_user.prepre_profile
  end
end
