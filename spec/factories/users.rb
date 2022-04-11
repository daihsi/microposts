FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet::email }
    password { '1111' }
    password_confirmation { '1111' }
  end
end
