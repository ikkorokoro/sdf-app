class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @profile = current_user.profile
  end

  def edit 
    @profile = current_user.profile
  end
  
  def update
    if current_user.profile.present?
      @profile = current_user.profile
    else
      @profile = current_user.build_profile
    end
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
    params.require(:profile).permit(:avatar, :name, :affiliation)
  end
end