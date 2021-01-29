class PassivesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @user = User.find(params[:account_id])
    @users = @user.followers
  end
end