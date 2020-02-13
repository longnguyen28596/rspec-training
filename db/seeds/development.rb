puts "Clear db"
User.destroy_all
Post.destroy_all

50.times do
  user = User.create(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number)
  Post.create user_id: user.id, title: Faker::Lorem.word, content: Faker::Lorem.paragraph_by_chars
  Post.create user_id: user.id, title: Faker::Lorem.word, content: Faker::Lorem.paragraph_by_chars
end
