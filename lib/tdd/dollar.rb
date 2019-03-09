class Tdd::Dollar < Tdd::Money
  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Tdd::Dollar.new(@amount * multiplier)
  end
end
