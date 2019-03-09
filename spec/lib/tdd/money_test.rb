require "rails_helper"

RSpec.describe "Money Test" do # rubocop:disable RSpec/DescribeClass
  it "test multiplication" do
    five = Tdd::Doller.new(5)
    product = five.times(2)
    expect(product.amount).to eq(10)
    product = five.times(3)
    expect(product.amount).to eq(15)
  end

  it "test equality" do
    expect(Tdd::Doller.new(5).equals(Tdd::Doller.new(5))).to be_truthy
    expect(Tdd::Doller.new(5).equals(Tdd::Doller.new(6))).to be_falsy
  end
end
