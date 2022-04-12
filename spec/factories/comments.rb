FactoryBot.define do
  factory :comment do
    content { Faker::String.random(length: 300) }
    association :post
    user { post.user }
  end
end
