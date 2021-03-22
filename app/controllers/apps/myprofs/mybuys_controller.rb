class Apps::Myprofs::MybuysController < Apps::Myprofs::ApplicationController

  def show
    @profile = current_user.profile
    @items = current_user.buy_rakutens
  end
end
