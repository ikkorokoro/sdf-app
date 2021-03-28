class Apps::Myprofiles::BuysController < Apps::Myprofiles::ApplicationController

  def show
    @profile = current_user.profile
    @items = current_user.buy_rakutens
  end
end
