class Tdd::Pair

  protected

    attr_reader :from, :to

  public

  def initialize(from, to)
    @from = from
    @to   = to
  end

  # eql?のオーバーライド
  def eql?(other)
    from == other.from && to == other.to
  end

  # eql?のオーバーライドに伴うhashのオーバーライド
  #  0にすることで線形探索になる
  def hash
    0
  end
end
