FactoryBot.define do
  factory :user do
    sequence(:name) { Gimei.name.kanji }
    sequence(:email) { Faker::Internet.email }
    sequence(:password) { "password" }
  end
end
