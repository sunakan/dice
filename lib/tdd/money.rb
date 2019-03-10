class Tdd::Money
  protected
  attr_accessor :amount
  attr_accessor :currency

  public
  def eql?(obj)
    @amount == obj.amount && self.class.equal?(obj.class)
  end

  def hash
    @amount.hash
  end

  def self.dollar(amount)
    Tdd::Dollar.new(amount)
  end

  def self.franc(amount)
    Tdd::Franc.new(amount, "CHF")
  end

  def currency
    @currency
  end
end
