class Tdd::Dollar < Tdd::Money
  def initialize(amount, currency)
    super(amount,  currency)
  end

  def times(multiplier)
    Tdd::Money.dollar(@amount * multiplier)
  end
end
