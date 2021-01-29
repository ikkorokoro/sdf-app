# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Faker::Config.locale = :en
User.create(
  email:                'aaaaaa@au.com',
  password:             'aaaaaa',
  account:              'arigatou'
  )

8.times do
email =  Faker::Internet.email
password = 'password'
account = Faker::JapaneseMedia::OnePiece.character
User.create!(
      email:                 email,
      password:              password,
      account:               account
      )
end
# article
users = User.all
3.times do
object = '戦闘服'
price = 2000
store = '留萌駐屯地'
category = '防寒具'
content = Faker::Lorem.sentence(word_count: 10)
users.each { |user| user.articles.create!( 
  object: object, 
  price: price, 
  store: store, 
  category: category, 
  content: content 
  )}
end
#image追加
articles = Article.all
articles.each { |article| article.image.attach(io: File.open('app/assets/images/vc-01.jpg'), filename: 'vc-01.jpg')}


#relastionship
users = User.all
user = users.first
following = users[1..8]
followers = users[1..8]
following.each { |followed| user.follow!(followed) }
followers.each { |follower| follower.follow!(user) }
