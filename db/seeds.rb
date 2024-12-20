# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
8.times do |i|
  User.create!({
    email: "test#{i}@gmail.com",
    password: "123456"
  })
end
5.times do |i|
  Category.create!(name: "Category #{i}")
end
6.times do |i|
  random_posts = Post.create!({
    title: "Post #{i}",
    content: "This is the content of post #{i}",
    user_id: User.all.sample.id,
    category_id: Category.all.sample.id
  })
  random_posts.picture.attach(io: File.open("db/images/#{i}.jpg"), filename: random_posts.title)
end
# sử dụng để update likes_count cho toàn bô các posts
# Post.find_each { |post| Post.reset_counters(post.id, :likes) }
