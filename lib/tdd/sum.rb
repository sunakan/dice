class Tdd::Sum
  include Tdd::Expression

  attr_accessor :augend, :addend

  def initialize(augend, addend)
    @augend = augend
    @addend = addend
  end

  def plus(addend)
    Tdd::Sum.new(self, addend)
  end

  def reduce(bank, to)
    amount = @augend.reduce(bank, to).amount + @addend.reduce(bank, to).amount
    Tdd::Money.new(amount, to)
  end
end
