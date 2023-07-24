# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



# create user
users = []
5.times do |i|
  user = User.create!(
    email: "user#{i + 1}@example.com",
    password: 'password'
  )
  users << user
end

# create post and comment
users.each do |user|
  20.times do |i|
    post = user.posts.create!(
      title: "Post #{i + 1} by #{user.email}",
      content: "Content of Post #{i + 1} by #{user.email}"
    )

    2.times do |j|
      comment = post.comments.create!(
        user: users.sample,
        content: "Comment #{j + 1} on Post #{i + 1} by #{user.email}"
      )

      # 添加巢狀留言
      1.times do |k|
        comment.children.create!(
          user: users.sample,
          content: "Nested Comment #{k + 1} on Comment #{j + 1} by #{user.email}",
          post_id: post.id 
        )
      end
    end
  end
end

# create vote
posts = Post.all
users.each do |user|
  posts.each do |post|
    # 随机模拟投票
    if rand(2).zero?
      post.votes.create!(user: user)
    end
  end
end
