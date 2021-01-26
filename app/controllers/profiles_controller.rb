class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @profile = current_user.profile
  end

  def edit 
    @profile = current_user.prepre_profile
  end
  
  def update
    @profile = current_user.prepre_profile
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
end