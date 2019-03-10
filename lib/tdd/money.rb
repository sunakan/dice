class Tdd::Money
  include Tdd::Expression

  attr_accessor :amount, :currency

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
    Tdd::Money.new(amount, "USD")
  end

  def self.franc(amount)
    Tdd::Money.new(amount, "CHF")
  end

  def currency
    @currency
  end

  def times(multiplier)
    Tdd::Money.new(@amount * multiplier, @currency)
  end

  def plus(addend)
    Tdd::Money.new(@amount + addend.amount, @currency)
  end

  # Tdd::Expression#reduceの実装
  def reduce(to)
    self
  end
end
