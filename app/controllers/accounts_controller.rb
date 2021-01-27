class AccountsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    if current_user == @user
      redirect_to profile_path
    end
  end
end