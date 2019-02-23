FactoryBot.define do
  factory :division do
    sequence(:division_id, 1) { |n| n }
    sequence(:division_name) { |n| "サンプル-#{n}部" }
  end
end
