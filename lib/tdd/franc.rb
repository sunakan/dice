class Tdd::Franc < Tdd::Money
  def initialize(amount)
    @amount = amount
    @currency = "CHF"
  end

  def times(multiplier)
    Tdd::Franc.new(@amount * multiplier)
  end
end
