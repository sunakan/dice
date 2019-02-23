FactoryBot.define do
  factory :member do
    sequence(:member_id, 1) { |n| n }
    sequence(:name) { Gimei.name.kanji }
  end
end
