FactoryBot.define do
  factory :paiza_division, class: "Paiza::Division" do
    sequence(:division_id, 1) {|n| n }
    sequence(:division_name) {|n| "サンプル-#{n}部" }
  end
end
