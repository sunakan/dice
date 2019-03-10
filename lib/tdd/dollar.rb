class Tdd::Dollar < Tdd::Money
  def initialize(amount)
    @amount = amount
    @currency = "USD"
  end

  def times(multiplier)
    Tdd::Dollar.new(@amount * multiplier)
  end
end
