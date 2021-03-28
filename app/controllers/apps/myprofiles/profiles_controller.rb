class Apps::Myprofiles::ProfilesController < Apps::Myprofiles::ApplicationController
  before_action :set_article, only: [:edit, :update]

  def show
    @profile = current_user.profile
    @articles = current_user.articles.with_attached_image.includes(:tags)
  end

  def edit
  end

  def update
    @profile.assign_attributes(params_profile)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィールを更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render 'edit'
    end
  end

  private
  def params_profile
    params.require(:profile).permit(:avatar, :name, :affiliation, :introduction)
  end

  def set_article
    @profile = current_user.prepre_profile
  end
end
