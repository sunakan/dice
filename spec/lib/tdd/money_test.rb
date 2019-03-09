require "rails_helper"

RSpec.describe "Money Test" do # rubocop:disable RSpec/DescribeClass
  it "test multiplication" do
    five = Tdd::Money.dollar(5)
    expect(five.times(2)).to eql(Tdd::Dollar.new(10))
    expect(five.times(3)).to eql(Tdd::Dollar.new(15))
  end

  it "test equality" do
    expect(Tdd::Dollar.new(5).eql?(Tdd::Dollar.new(5))).to be_truthy
    expect(Tdd::Dollar.new(5).eql?(Tdd::Dollar.new(6))).to be_falsy
    expect(Tdd::Franc.new(5).eql?(Tdd::Franc.new(5))).to be_truthy
    expect(Tdd::Franc.new(5).eql?(Tdd::Franc.new(6))).to be_falsy
    expect(Tdd::Dollar.new(5).eql?(Tdd::Franc.new(5))).to be_falsy
  end

  it "test franc multiplication" do
    five = Tdd::Franc.new(5)
    expect(five.times(2)).to eql(Tdd::Franc.new(10))
    expect(five.times(3)).to eql(Tdd::Franc.new(15))
  end
end
