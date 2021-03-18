class RakutensController < ApplicationController
  PER = 30
  def index
    @items = RakutenWebService::Ichiba::Item.search(shopCode: 'shop-senjin', page: params[:page], hits: PER)
    # ページ数
    @total_pages = @items.response.page_count
    # 商品数
    @total_count = @items.response.count
    # 空の配列で構わない
    @dummy = Kaminari.paginate_array([]).page(params[:page])
  end

  def search
    @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword], shopCode: 'shop-senjin', page: params[:page], hits: PER)
    # ページ数
    @total_pages = @items.response.page_count
    # 商品数
    @total_count = @items.response.count
    # 空の配列で構わない
    @dummy = Kaminari.paginate_array([]).page(params[:page])
end
end