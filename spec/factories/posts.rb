FactoryBot.define do
  factory :post do
    content { Faker::String.random(length: 300) }
  end
end
