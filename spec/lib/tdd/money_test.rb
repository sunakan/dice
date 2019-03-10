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
    expect(Tdd::Money.franc(5).eql?(Tdd::Money.franc(5))).to be_truthy
    expect(Tdd::Money.franc(5).eql?(Tdd::Money.franc(6))).to be_falsy
    expect(Tdd::Money.dollar(5).eql?(Tdd::Money.franc(5))).to be_falsy
  end

  it "test franc multiplication" do
    five = Tdd::Money.franc(5)
    expect(five.times(2)).to eql(Tdd::Money.franc(10))
    expect(five.times(3)).to eql(Tdd::Money.franc(15))
  end

  it "test currency" do
    expect(Tdd::Money.dollar(1).currency).to eq("USD")
    expect(Tdd::Money.franc(1).currency).to eq("CHF")
  end
end
