class Tdd::Money
  protected
  attr_accessor :amount
  attr_accessor :currency

  public
  def initialize(amount, currency)
    @amount   = amount
    @currency = currency
  end

  def eql?(obj)
    @amount == obj.amount && @currency == obj.currency
  end

  def hash
    @amount.hash
  end

  def self.dollar(amount)
    Tdd::Dollar.new(amount, "USD")
  end

  def self.franc(amount)
    Tdd::Franc.new(amount, "CHF")
  end

  def currency
    @currency
  end

  def times(multiplier)
    Tdd::Money.new(@amount * multiplier, @currency)
  end
end
