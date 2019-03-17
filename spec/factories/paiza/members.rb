FactoryBot.define do
  factory :paiza_member, class: "Paiza::Member" do
    sequence(:member_id, 1) {|n| n }
    sequence(:name) { Gimei.name.kanji }
  end
end
