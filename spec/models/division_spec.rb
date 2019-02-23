require "rails_helper"

RSpec.describe Division, type: :model do
  it "division_id, division_nameがあれば有効である" do
    division = FactoryBot.build(:division)
    expect(division).to be_valid
  end
  it "division_idがなければ無効である" do
    division = FactoryBot.build(:division, division_id: nil)
    expect(division).not_to be_valid
  end
  it "division_idの重複は許可しない" do
    division  = FactoryBot.create(:division)
    division2 = FactoryBot.build(:division, division_id: division.division_id)
    expect(division2).not_to be_valid
  end
  it "division_nameがなければ無効である" do
    division = FactoryBot.build(:division, division_name: nil)
    expect(division).not_to be_valid
  end
end
