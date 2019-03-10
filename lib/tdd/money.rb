class Tdd::Money
  protected
  attr_accessor :amount

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
    Tdd::Franc.new(amount)
  end

  # Javaのabstract methodと似たことをRubyで表現
  def currency
    raise NotImplementedError.new("#{self.class}##{__method__}を実装してください")
  end
end
