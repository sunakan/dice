class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run
    setup()
    send(@name)
  end
end

class WasRun < TestCase
  attr_reader :was_run, :was_setup
  def setup
    @was_run   = nil
    @was_setup = 1
  end
  def test_method
    @was_run = 1
  end
end

class TestCaseTest < TestCase
  private
    attr_accessor :test
  public
  def test_running
    test = WasRun.new("test_method")
    test.run()
    raise if test.was_run.nil?
  end

  def test_setup
    @test.run()
    raise if test.was_setup.nil?
  end

  def setup
    @test = WasRun.new("test_method")
  end
end

TestCaseTest.new("test_running").run()
TestCaseTest.new("test_setup").run()
