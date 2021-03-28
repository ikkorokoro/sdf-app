class Apps::Senjins::BuylistsController < Apps::Senjins::ApplicationController
  before_action :set_rakuten, only: [:create, :destroy]
  
  def create
    @item.buylists.create!(user_id: current_user.id)
    redirect_to rakutens_path
  end

  def destroy
    @item = item.buylists.find_by(user_id: current_user.id)
    @item.destroy!
    redirect_to rakutens_path
  end

  private
  def set_rakuten
    @item = Rakuten.find(params[:rakuten_id])
  end
end
