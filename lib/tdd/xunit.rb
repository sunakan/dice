class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run
    self.send(@name)
  end
end

class WasRun < TestCase
  attr_reader :was_run
  def initialize(name)
    super(name)
    @was_run = nil
  end

  def test_method
    @was_run = 1
  end
end

class TestCaseTest < TestCase
  def test_running
    test = WasRun.new("test_method")
    raise unless test.was_run.nil?
    test.run
    raise if test.was_run.nil?
  end
end

TestCaseTest.new("test_running").run()
