class Apps::Senjins::RakutensController < Apps::Senjins::ApplicationController
  before_action :set_rakuten_q, only: [:index, :search]

  def index
    create_rakuten_data(params)

    @items = Rakuten.all.page(params[:page])
    # 全アイテム数
    @total_count = @results.response.count
  end

  def search
    @items = @q.result.page(params[:page]).per(30)
    @count = @q.result.count
  end

  private
    def create_rakuten_data(params)
      @results = RakutenWebService::Ichiba::Item.search(
        shopCode: 'shop-senjin',
        page: params[:page],
        hits: 30)

      @results.each do |result|
        item = Rakuten.new(read(result))
        unless Rakuten.all.exists?(item_name: item.item_name)
          item.save
        end
      end
    end

    def read(result)
      image_url = result['mediumImageUrls'][0]
      item_name = result['itemName']
      item_price = result['itemPrice']
      item_url = result['itemUrl']
      shop_name = result['shopCode']
      genre_id = result['genreId']
      review_average = result['reviewAverage']
      {
        image_urls: image_url,
        item_name: item_name,
        item_price: item_price,
        item_url: item_url,
        shop_name: shop_name,
        genle_id: genre_id,
        review_average: review_average
      }
    end

    def set_rakuten_q
      @r = Rakuten.ransack(params[:q])
    end
end
