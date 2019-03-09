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
end
