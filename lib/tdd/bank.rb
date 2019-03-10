class Tdd::Bank
  private

    attr_accessor :rates

  public

  def initialize
    @rates = {}
  end

  # 換算メソッド
  # @params [Tdd::Expression] source 換算したいExpression
  # @params [String] to 換算先の通貨名
  # @return [Tdd::Money] 換算後の通貨
  def reduce(source, to)
    source.reduce(self, to)
  end

  # レートの追加
  # @params [String] from 換算元の通貨名
  # @params [String] to 換算先の通貨名
  # @params [Integer] rate 換算レート
  def add_rate(from, to, rate)
    pair = Tdd::Pair.new(from, to)
    rates[pair] = rate
  end

  # レートの取得
  # @params [String] from 換算元の通貨名
  # @params [String] to 換算先の通貨名
  # @return [Integer] 換算レート
  def rate(from, to)
    return 1 if from == to

    pair = Tdd::Pair.new(from, to)
    rates[pair]
  end
end
