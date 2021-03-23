class Apps::Senjins::RakutensController < Apps::Senjins::ApplicationController
  before_action :set_q, only: [:index, :search]

  PER = 30
  def index
    # binding.pry
    items = []
    results = RakutenWebService::Ichiba::Item.search(
      shopCode: 'shop-senjin',
      page: params[:page],
      hits: PER)
    #resultsに楽天APIから取得したデータ（jsonデータ）を格納します。
    # read(result)に、privateメソッド
    results.each do |result|
      item = Rakuten.new(read(result))
      items << item
    end
    #「items」内の各データを保存。
    #すでに保存済は除外するためにunless使用。
    items.each do |item|
      unless Rakuten.all.exists?(item_name: item.item_name)
        item.save
      end
    end
    @items = Rakuten.all.page(params[:page])
    # 全アイテム数
    @total_count = results.response.count
  end

  def search
    @items = @q.result.page(params[:page]).per(30)
    @count = @q.result.count
  end

  private
    #「楽天APIのデータから必要なデータを絞り込む」、且つ「対応するカラムにデータを格納する」メソッド
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

    def set_q
      @q = Rakuten.ransack(params[:q])
    end
end
