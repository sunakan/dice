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

  it "test simple addition" do
    five = Tdd::Money.dollar(5)
    sum = five.plus(Tdd::Money.dollar(5))
    bank = Tdd::Bank.new
    reduced = bank.reduce(sum, "USD")
    expect(reduced).to eql(Tdd::Money.dollar(10))
  end

  it "test reduce sum" do
    sum = Tdd::Sum.new(Tdd::Money.dollar(3), Tdd::Money.dollar(4))
    bank = Tdd::Bank.new
    result = bank.reduce(sum, "USD")
    expect(result).to eql(Tdd::Money.dollar(7))
  end

  it "test reduce money different currency" do
    bank = Tdd::Bank.new
    bank.add_rate("CHF", "USD", 2)
    result = bank.reduce(Tdd::Money.franc(2), "USD")
    expect(result).to eql(Tdd::Money.dollar(1))
  end

  it "test identity rate" do
    bank = Tdd::Bank.new
    expect(bank.rate("USD", "USD")).to eq(1)
  end

  it "test mixed addition" do
    five_bucks = Tdd::Money.dollar(5)
    ten_francs = Tdd::Money.franc(10)
    bank = Tdd::Bank.new
    bank.add_rate("CHF", "USD", 2)
    result = bank.reduce(five_bucks.plus(ten_francs), "USD")
    expect(result).to eql(Tdd::Money.dollar(10))
  end

  it "test sum plus money" do
    five_bucks = Tdd::Money.dollar(5)
    ten_francs = Tdd::Money.franc(10)
    bank = Tdd::Bank.new
    bank.add_rate("CHF", "USD", 2)
    sum = Tdd::Sum.new(five_bucks, ten_francs).plus(five_bucks)
    result = bank.reduce(sum, "USD")
    expect(result).to eql(Tdd::Money.dollar(15))
  end

  it "test sum times" do
    five_bucks = Tdd::Money.dollar(5)
    ten_francs = Tdd::Money.franc(10)
    bank = Tdd::Bank.new
    bank.add_rate("CHF", "USD", 2)
    sum = Tdd::Sum.new(five_bucks, ten_francs).times(2)
    result = bank.reduce(sum, "USD")
    expect(result).to eql(Tdd::Money.dollar(20))
  end
end
