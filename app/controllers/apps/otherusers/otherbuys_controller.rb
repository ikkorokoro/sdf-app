class Apps::Otherusers::OtherbuysController < Apps::Otherusers::ApplicationController
  def show
    @user = User.find(params[:account_id])
    @items = @user.buy_rakutens
  end
end
