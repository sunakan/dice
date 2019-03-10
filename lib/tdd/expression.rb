module Tdd::Expression
  def reduce(to)
    raise NotImplementedError.new("#{self.class}##{__method__} が実装されていません")
  end
end
