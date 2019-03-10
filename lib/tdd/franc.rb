class Tdd::Franc < Tdd::Money
  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def times(multiplier)
    Tdd::Money.franc(@amount * multiplier)
  end
end
