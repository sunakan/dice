module Tdd::Expression
  def plus(addend)
    raise NotImplementedError, "#{self.class}##{__method__} が実装されていません"
  end

  def times(multiplier)
    raise NotImplementedError, "#{self.class}##{__method__} が実装されていません"
  end

  def reduce(bank, to)
    raise NotImplementedError, "#{self.class}##{__method__} が実装されていません"
  end
end
