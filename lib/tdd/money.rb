class Tdd::Money
  include Tdd::Expression

  attr_reader :amount, :currency

  def initialize(amount, currency)
    @amount   = amount
    @currency = currency
  end

  # eql?のオーバーライド
  def eql?(other)
    amount == other.amount && currency == other.currency
  end

  # eql?のオーバーライドに伴うhashのオーバーライド
  def hash
    amount.hash
  end

  # 米ドル通貨生成メソッド
  # FactoryMethodパターン
  # @params [Integer] amount 量
  # @return [Tdd::Money] 米ドル通貨のMoneyインスタンス
  def self.dollar(amount)
    Tdd::Money.new(amount, Tdd::Currency::USD)
  end

  # スイスフラン通貨生成メソッド
  # FactoryMethodパターン
  # @params [Integer] amount 量
  # @return [Tdd::Money] スイスフラン通貨のMoneyインスタンス
  def self.franc(amount)
    Tdd::Money.new(amount, Tdd::Currency::CHF)
  end

  # Tdd::Expression#timesの実装
  def times(multiplier)
    Tdd::Money.new(amount * multiplier, currency)
  end

  # Tdd::Expression#plusの実装
  def plus(addend)
    Tdd::Sum.new(self, addend)
  end

  # Tdd::Expression#reduceの実装
  def reduce(bank, to)
    rate = bank.rate(currency, to)
    Tdd::Money.new(amount / rate, to)
  end
end
