class Tdd::Franc
  protected
  attr_accessor :amount

  public
  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Tdd::Franc.new(@amount * multiplier)
  end

  def eql?(obj)
    obj.is_a?(self.class) && (@amount == obj.amount)
  end

  def hash
    @amount.hash
  end
end
