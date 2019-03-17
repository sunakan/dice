require "rails_helper"

RSpec.describe Paiza::Member, type: :model do
  it "member_id, nameがあれば有効である" do
    member = FactoryBot.build(:paiza_member)
    expect(member).to be_valid
  end
  it "member_idがなければ無効である" do
    member = FactoryBot.build(:paiza_member, member_id: nil)
    expect(member).not_to be_valid
  end
  it "member_idの重複は許可しない" do
    member  = FactoryBot.create(:paiza_member)
    member2 = FactoryBot.build(:paiza_member, member_id: member.member_id)
    expect(member2).not_to be_valid
  end
  it "nameがなければ無効である" do
    member = FactoryBot.build(:paiza_member, name: nil)
    expect(member).not_to be_valid
  end
end
