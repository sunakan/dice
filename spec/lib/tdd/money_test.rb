require "rails_helper"

RSpec.describe "Money Test" do # rubocop:disable RSpec/DescribeClass
  it "test multiplication" do
    five = Tdd::Doller.new(5)
    five.times(2)
    it(five.amount).to eq(10)
  end
end
