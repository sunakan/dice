class Tdd::Doller < Tdd::Money
  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Tdd::Doller.new(@amount * multiplier)
  end
end
