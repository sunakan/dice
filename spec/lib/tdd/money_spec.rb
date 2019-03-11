require "rails_helper"

RSpec.describe Tdd::Money do
  it "乗算" do
    five = Tdd::Money.dollar(5)
    expect(five.times(2)).to eql(Tdd::Money.dollar(10))
    expect(five.times(3)).to eql(Tdd::Money.dollar(15))
    five = Tdd::Money.franc(5)
    expect(five.times(2)).to eql(Tdd::Money.franc(10))
    expect(five.times(3)).to eql(Tdd::Money.franc(15))
  end

  it "等価性" do
    expect(Tdd::Money.dollar(5)).to be_eql(Tdd::Money.dollar(5))
    expect(Tdd::Money.dollar(5)).not_to be_eql(Tdd::Money.dollar(6))
    expect(Tdd::Money.dollar(5)).not_to be_eql(Tdd::Money.franc(5))
  end

  it "ファクトリメソッドから生成されたインスタンスの通貨名" do
    expect(Tdd::Money.dollar(1).currency).to eq("USD")
    expect(Tdd::Money.franc(1).currency).to eq("CHF")
  end

  it "加算" do
    five = Tdd::Money.dollar(5)
    sum = five.plus(Tdd::Money.dollar(5))
    bank = Tdd::Bank.new
    reduced = bank.reduce(sum, "USD")
    expect(reduced).to eql(Tdd::Money.dollar(10))
  end

  it "reduceメソッドによる計算" do
    sum = Tdd::Sum.new(Tdd::Money.dollar(3), Tdd::Money.dollar(4))
    bank = Tdd::Bank.new
    result = bank.reduce(sum, "USD")
    expect(result).to eql(Tdd::Money.dollar(7))
  end

  it "異なる通貨へ換算" do
    bank = Tdd::Bank.new
    bank.add_rate("CHF", "USD", 2)
    result = bank.reduce(Tdd::Money.franc(2), "USD")
    expect(result).to eql(Tdd::Money.dollar(1))
  end

  it "通貨の計算にてA国からA国の通貨への変換レートの確認" do
    bank = Tdd::Bank.new
    expect(bank.rate("USD", "USD")).to eq(1)
  end

  it "異なる通貨同士の加算" do
    five_bucks = Tdd::Money.dollar(5)
    ten_francs = Tdd::Money.franc(10)
    bank = Tdd::Bank.new
    bank.add_rate("CHF", "USD", 2)
    result = bank.reduce(five_bucks.plus(ten_francs), "USD")
    expect(result).to eql(Tdd::Money.dollar(10))
  end

  it "Sumクラスの加算" do
    five_bucks = Tdd::Money.dollar(5)
    ten_francs = Tdd::Money.franc(10)
    bank = Tdd::Bank.new
    bank.add_rate("CHF", "USD", 2)
    sum = Tdd::Sum.new(five_bucks, ten_francs).plus(five_bucks)
    result = bank.reduce(sum, "USD")
    expect(result).to eql(Tdd::Money.dollar(15))
  end

  it "Sumクラスの乗算" do
    five_bucks = Tdd::Money.dollar(5)
    ten_francs = Tdd::Money.franc(10)
    bank = Tdd::Bank.new
    bank.add_rate("CHF", "USD", 2)
    sum = Tdd::Sum.new(five_bucks, ten_francs).times(2)
    result = bank.reduce(sum, "USD")
    expect(result).to eql(Tdd::Money.dollar(20))
  end
end
