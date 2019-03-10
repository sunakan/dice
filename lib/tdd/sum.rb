class Tdd::Sum
  include Tdd::Expression

  attr_accessor :augend, :addend

  def initialize(augend, addend)
    @augend = augend
    @addend = addend
  end

  def reduce(to)
    amount = @augend.amount + @addend.amount
    Tdd::Money.new(amount, to)
  end
end
