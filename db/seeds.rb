# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

password = '123abc'

1.upto(5) do |i|
    User.create(
    email: "#{i}-user@example.com",
    password: password,
    password_confirmation: password
  )

  
  Post.create(
    title: "Lorem, ipsum dolor",
    content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quasi rem eius sed nihil sint necessitatibus illum earum accusantium non atque! Vel quasi, minima, blanditiis voluptatem enim aliquam asperiores nihil sint deserunt odio explicabo consectetur unde!",
    user_id: i,
  )

  Comment.create(
    content: "Love your work mate!",
    user_id: i,
    post_id: i,
  )

end
