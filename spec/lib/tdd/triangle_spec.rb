require "rails_helper"

RSpec.describe Tdd::Triangle do
  describe "正三角形のときは 1" do
    it { expect(Tdd::Triangle.judge(1, 1, 1)).to eq(1) }
  end

  describe "二等辺三角形のときは 2" do
    it { expect(Tdd::Triangle.judge(1, 2, 2)).to eq(2) }
  end

  describe "不等辺三角形のときは 3" do
    it { expect(Tdd::Triangle.judge(2, 3, 4)).to eq(3) }
  end

  describe "三角形ではない時、例外を投げる" do
    it { expect { Tdd::Triangle.judge(0, 0, 0) }.to raise_error(ArgumentError) }
    it { expect { Tdd::Triangle.judge(1, 2, 3) }.to raise_error(ArgumentError) }
    it { expect { Tdd::Triangle.judge(-1, -1, -1) }.to raise_error(ArgumentError) }
  end
end
