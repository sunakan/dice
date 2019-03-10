class Tdd::Pair
  protected

    attr_accessor :from, :to

  public

  def initialize(from, to)
    @from = from
    @to   = to
  end

  def eql?(other)
    @from == other.from && @to == other.to
  end

  def hash
    0
  end
end
