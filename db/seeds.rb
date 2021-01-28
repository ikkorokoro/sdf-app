# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  email:                'aaaaaa@au.com',
  password:             'aaaaaa',
  account:              'arigatou'
  )

8.times do
email = Faker::Lorem.sentence(word_count: 8) + '@au.com'
password = 'password'
account = Faker::Lorem.sentence(word_count: 6)
User.create!(
      email:                 email,
      password:              password,
      account:               account
      )
end

# article
users = User.all
5.times do
object = '防寒具'
price = 2000
store = '遠軽駐屯地'
category = '防寒具'
content = Faker::Lorem.sentence(word_count: 30)
users.each { |user| user.articles.create!( object: object, price: price, store: store, category: category, content: content )}
end

#relastionship
users = User.all
user = users.first
following = users[1..8]
followers = users[1..8]
following.each { |followed| user.follow!(followed) }
followers.each { |follower| follower.follow!(user) }
