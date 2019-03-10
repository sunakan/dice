class Tdd::Franc < Tdd::Money
  def initialize(amount, currency)
    @amount = amount
    @currency = "CHF"
  end

  def times(multiplier)
    Tdd::Franc.new(@amount * multiplier, nil)
  end
end
