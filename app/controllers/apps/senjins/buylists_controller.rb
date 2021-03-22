class Apps::Senjins::BuylistsController < Apps::Senjins::ApplicationController

  def create
    item = Rakuten.find(params[:rakuten_id])
    item.buylists.create!(user_id: current_user.id)
    redirect_to rakutens_path
  end

  def destroy
    item = Rakuten.find(params[:rakuten_id])
    item = item.buylists.find_by(user_id: current_user.id)
    item.destroy!
    redirect_to rakutens_path
  end
end
