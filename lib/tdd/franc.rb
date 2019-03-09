class Tdd::Franc < Tdd::Money
  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Tdd::Franc.new(@amount * multiplier)
  end
end
