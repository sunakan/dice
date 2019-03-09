require "rails_helper"

RSpec.describe "Money Test" do # rubocop:disable RSpec/DescribeClass
  it "test multiplication" do
    five = Tdd::Money.dollar(5)
    expect(five.times(2)).to eql(Tdd::Money.dollar(10))
    expect(five.times(3)).to eql(Tdd::Money.dollar(15))
  end

  it "test equality" do
    expect(Tdd::Money.dollar(5).eql?(Tdd::Money.dollar(5))).to be_truthy
    expect(Tdd::Money.dollar(5).eql?(Tdd::Money.dollar(6))).to be_falsy
    expect(Tdd::Franc.new(5).eql?(Tdd::Franc.new(5))).to be_truthy
    expect(Tdd::Franc.new(5).eql?(Tdd::Franc.new(6))).to be_falsy
    expect(Tdd::Money.dollar(5).eql?(Tdd::Franc.new(5))).to be_falsy
  end

  it "test franc multiplication" do
    five = Tdd::Franc.new(5)
    expect(five.times(2)).to eql(Tdd::Franc.new(10))
    expect(five.times(3)).to eql(Tdd::Franc.new(15))
  end
end
