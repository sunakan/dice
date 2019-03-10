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

  attr_reader :currency

  # Tdd::Expression#timesの実装
  def times(multiplier)
    Tdd::Money.new(@amount * multiplier, @currency)
  end

  # Tdd::Expression#plusの実装
  def plus(addend)
    Tdd::Sum.new(self, addend)
  end

  # Tdd::Expression#reduceの実装
  def reduce(bank, to)
    rate = bank.rate(@currency, to)
    Tdd::Money.new(@amount / rate, to)
  end
end
