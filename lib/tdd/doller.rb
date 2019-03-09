class Tdd::Doller
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end
  def times(multiplier)
    Tdd::Doller.new(@amount * multiplier)
  end
end
