FactoryBot.define do
  factory :user do
    name { Faker::Name.name[0..5] }
    phone { Faker::PhoneNumber.phone_number }
  end
end
