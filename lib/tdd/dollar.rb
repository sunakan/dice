class Tdd::Dollar < Tdd::Money
  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def times(multiplier)
    Tdd::Money.dollar(@amount * multiplier)
  end
end
