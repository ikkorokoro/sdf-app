class RakutensController < ApplicationController
  def index
    if params[:page].present? && params[:page] < '13'
      @items = RakutenWebService::Ichiba::Item.search(shopCode: 'shop-senjin', page: params[:page])
      @senjins = []
        @items.each do |item|
          @senjins.push(item)
      @senjins = Kaminari.paginate_array(@senjins).page(params[:page])
        end
    else
      @items = RakutenWebService::Ichiba::Item.search(shopCode: 'shop-senjin', page: params[:page])
      @senjins = []
        @items.each do |item|
          @senjins.push(item)
      @senjins = Kaminari.paginate_array(@senjins).page(params[:page]).per(30)
        end
    end
end

  def search
    if params[:keyword].present?
      items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      @senjins = []
      items.each do |item|
        @senjins.push(item)
      end
      @senjins = Kaminari.paginate_array(@senjins).page(params[:page])
    end
  end
end