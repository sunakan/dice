class Tdd::Franc < Tdd::Money
  def initialize(amount, currency)
    super(amount,  currency)
  end

  def times(multiplier)
    Tdd::Money.franc(@amount * multiplier)
  end
end
