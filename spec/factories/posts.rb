FactoryBot.define do
  factory :post do
    user_id { FactoryBot.create :user }
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph_by_chars }
  end
end
