module Tdd::Triangle

  # 与えられた3つの整数から作る三角形の種類を判別する
  #
  # @param [Integer] a 1つの辺長さ
  # @param [Integer] b 1つの辺長さ
  # @param [Integer] c 1つの辺長さ
  #
  # @raise 与えられた3つの整数から三角形ができない場合、例外が投げられる
  #
  # @return [Integer] 三角形の種類に応じた整数
  def self.judge(a, b, c)
    max = [a,b,c].max
    raise ArgumentError if max<=0 || ([a,b,c].sum-max)<=max
    [a,b,c].uniq.size
  end
end
