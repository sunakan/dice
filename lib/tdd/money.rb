class Tdd::Money
  protected
  attr_accessor :amount

  public
  def eql?(obj)
    @amount == obj.amount
  end

  def hash
    @amount.hash
  end
end
