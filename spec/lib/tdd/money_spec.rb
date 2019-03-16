require "rails_helper"

RSpec.describe Tdd::Money do

  let(:five_bucks)  { Tdd::Money.dollar(5) }
  let(:five_francs) { Tdd::Money.franc(5) }
  let(:ten_bucks)   { Tdd::Money.dollar(10) }
  let(:ten_francs)  { Tdd::Money.franc(10) }
  let(:bank) { Tdd::Bank.new.tap {|bank| bank.add_rate(Tdd::Currency::CHF, Tdd::Currency::USD, 2) } }

  describe "乗算" do
    it { expect(five_bucks.times(2)).to eql(Tdd::Money.dollar(10)) }
    it { expect(five_bucks.times(3)).to eql(Tdd::Money.dollar(15)) }
    it { expect(five_francs.times(2)).to eql(Tdd::Money.franc(10)) }
    it { expect(five_francs.times(3)).to eql(Tdd::Money.franc(15)) }
  end

  describe "等価性" do
    it { expect(Tdd::Money.dollar(5)).to be_eql(Tdd::Money.dollar(5)) }
    it { expect(Tdd::Money.dollar(5)).not_to be_eql(Tdd::Money.dollar(6)) }
    it { expect(Tdd::Money.dollar(5)).not_to be_eql(Tdd::Money.franc(5)) }
  end

  describe "ファクトリメソッドから生成されたインスタンスの通貨名" do
    it { expect(Tdd::Money.dollar(1).currency).to eq(Tdd::Currency::USD) }
    it { expect(Tdd::Money.franc(1).currency).to eq(Tdd::Currency::CHF) }
  end

  it "加算" do
    sum = five_bucks.plus(Tdd::Money.dollar(5))
    reduced = bank.reduce(sum, Tdd::Currency::USD)
    expect(reduced).to eql(Tdd::Money.dollar(10))
  end

  it "reduceメソッドによる計算" do
    sum = Tdd::Sum.new(Tdd::Money.dollar(3), Tdd::Money.dollar(4))
    result = bank.reduce(sum, Tdd::Currency::USD)
    expect(result).to eql(Tdd::Money.dollar(7))
  end

  it "異なる通貨へ換算" do
    result = bank.reduce(Tdd::Money.franc(2), Tdd::Currency::USD)
    expect(result).to eql(Tdd::Money.dollar(1))
  end

  it "通貨の計算にてA国からA国の通貨への変換レートの確認" do
    expect(bank.rate(Tdd::Currency::USD, Tdd::Currency::USD)).to eq(1)
  end

  it "異なる通貨同士の加算" do
    result = bank.reduce(five_bucks.plus(ten_francs), Tdd::Currency::USD)
    expect(result).to eql(Tdd::Money.dollar(10))
  end

  it "Sumクラスの加算" do
    sum = Tdd::Sum.new(five_bucks, ten_francs).plus(five_bucks)
    result = bank.reduce(sum, Tdd::Currency::USD)
    expect(result).to eql(Tdd::Money.dollar(15))
  end

  it "Sumクラスの乗算" do
    sum = Tdd::Sum.new(five_bucks, ten_francs).times(2)
    result = bank.reduce(sum, Tdd::Currency::USD)
    expect(result).to eql(Tdd::Money.dollar(20))
  end
end
