# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
# Faker::Config.locale = :en
User.create(
  email:                'aaaaaa@au.com',
  password:             'aaaaaa',
  account:              'arigatou'
  )

9.times do
email =  Faker::Internet.email
password = 'password'
account =  Gimei.name
User.create!(
      email:                 email,
      password:              password,
      account:               account
      )
end
# #article
users = User.all
gruop1 = users[0..1]
gruop2 = users[2..3]
gruop3 = users[4..5]
gruop4 = users[6..7]
gruop5 = users[8..9]

#category
names = ['鉄帽', '中帽', '帽子類', '手袋', '戦闘服','バッグ',' 雨衣','装具','防寒類','靴','小物']
names.each { |name| Category.create!(category_name: name)}
# #tsgs
tags = ['訓練','演習','室内','野外','射撃','夏用','冬用','夜間 ','安価','高価','コスパ','軽量','重量','機能性','収納力','耐久性','防寒性','防水性','防音性','偽装','迷彩','OD色','白色','黒色','大きい','小さい']
tags.each {|tag| Tag.create!(name: tag)}

object = '戦闘服'
price = 8000
store = '留萌駐屯地'
category_id = 41
tag_ids = [1, 51, 91]
rate = 2
content = Faker::Lorem.sentence(word_count: 10)
gruop1.each { |user| user.articles.create!( 
  object: object,
  price: price,
  store: store,
  category_id: category_id,
  content: content,
  rate: rate,
  tag_ids: tag_ids
  )}

object = '手袋'
price = 2000
store = '旭川駐屯地'
category_id = 31
tag_ids = [1, 31, 51]
rate = 3
content = Faker::Lorem.sentence(word_count: 10)
gruop2.each { |user| user.articles.create!( 
  object: object,
  price: price,
  store: store,
  category_id: category_id,
  content: content,
  rate: rate,
  tag_ids: tag_ids
  )}

object = 'バッグ'
price = 10000
store = '札幌駐屯地'
category_id = 51
tag_ids = [11, 91, 201]
rate = 5
content = Faker::Lorem.sentence(word_count: 10)
gruop3.each { |user| user.articles.create!( 
  object: object,
  price: price,
  store: store,
  category_id: category_id,
  content: content,
  rate: rate,
  tag_ids: tag_ids
  )}

object = '鉄帽'
price = 12000
store = '釧路駐屯地'
category_id = 1
tag_ids = [11, 111, 201]
rate = 5
content = Faker::Lorem.sentence(word_count: 10)
gruop4.each { |user| user.articles.create!( 
  object: object,
  price: price,
  store: store,
  category_id: category_id,
  content: content,
  rate: rate,
  tag_ids: tag_ids
  )}
  
object = '鉄帽'
price = 10000
store = '留萌駐屯地'
category_id = 1
tag_ids = [1, 81, 201]
rate = 4
content = Faker::Lorem.sentence(word_count: 10)
gruop5.each { |user| user.articles.create!( 
  object: object,
  price: price,
  store: store,
  category_id: category_id,
  content: content,
  rate: rate,
  tag_ids: tag_ids
  )}


# image追加
articles = Article.all
onearticles = articles[0..1]#戦闘服
twoarticles = articles[2..3]#手袋
threearticles = articles[4..5]#バッグ
forcearticles = articles[6..9]
onearticles.each { |onearticle| onearticle.image.attach(io: File.open('app/assets/images/vc-01.jpg'), filename: 'vc-01.jpg')}
twoarticles.each { |twoarticle| twoarticle.image.attach(io: File.open('app/assets/images/C704-01.jpg'), filename: 'C704-01.jpg')}
threearticles.each { |threearticle| threearticle.image.attach(io: File.open('app/assets/images/ryukkudai-01.jpg'), filename: 'ryukkudai-01.jpg')}
forcearticles.each  { |forcearticle| forcearticle.image.attach(io: File.open('app/assets/images/type88-01.jpg'), filename: 'type88-01.jpg')}

#like
users = User.all
user = users.first
users = users[1..7]
articles = Article.all
first_article = Article.first
second_article = Article.second
active_articles = articles[1..7]
active_articles.each { |active_article| active_article.likes.create!(user_id: user.id) }
users.each { |user| first_article.likes.create!(user_id: user.id) }
users.each { |user| second_article.likes.create!(user_id: user.id) }


#relastionship
users = User.all
user = users.first
following = users[1..8]
followers = users[1..8]
following.each { |followed| user.follow!(followed) }
followers.each { |follower| follower.follow!(user) }