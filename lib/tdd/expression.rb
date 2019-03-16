# JavaのInterfaceっぽい表現をするためにmoduleを使用
module Tdd::Expression
  # 足し算メソッド
  # @params [Tdd::Expression] addend 加数
  # @return [Tdd::Expression] 和
  def plus(addend)
    raise NotImplementedError, "#{self.class}##{__method__} が実装されていません"
  end

  # 掛け算メソッド
  # @params [Integer] multiplier 乗数
  # @return [Tdd::Expression] 積
  def times(multiplier)
    raise NotImplementedError, "#{self.class}##{__method__} が実装されていません"
  end

  # 換算メソッド
  # @params [Tdd::Bank] bank 換算レートを知っている銀行インスタンス
  # @params [String] to 換算先の通貨名
  # @return [Tdd::Money] 換算後の通貨
  def reduce(bank, to)
    raise NotImplementedError, "#{self.class}##{__method__} が実装されていません"
  end
end
