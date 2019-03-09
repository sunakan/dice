class Tdd::Doller
  # Javaのprivate => Rubyのprotected
  protected
  attr_accessor :amount

  # publicとわざわざ書いてある理由
  #   protectedをわかりやすく上で宣言したかったため
  public
  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Tdd::Doller.new(@amount * multiplier)
  end

  # Javaで言うところのequals(Object obj)
  def eql?(obj)
    obj.is_a?(self.class) && (@amount == obj.amount)
  end

  # eql?をオーバーライドするとhashも再定義しなさいとある
  # Hashクラスのkeyとして使われた時の挙動の為
  # 今回のコードには不要だが再定義しておく(デフォルトはobject_id)
  def hash
    @amount.hash
  end
end
