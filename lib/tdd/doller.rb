class Tdd::Doller
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Tdd::Doller.new(@amount * multiplier)
  end

  def equals(doller)
    @amount == doller.amount
  end
end
