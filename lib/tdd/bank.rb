class Tdd::Bank
  private
  attr_accessor :rates

  public
  def initialize
    @rates = {}
  end

  def reduce(source, to)
    source.reduce(self, to)
  end

  def add_rate(from, to, rate)
    pair = Tdd::Pair.new(from, to)
    rates[pair] = rate
  end

  def rate(from, to)
    return 1 if from == to
    pair = Tdd::Pair.new(from, to)
    rates[pair]
  end
end
