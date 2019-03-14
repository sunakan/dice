class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run
    setup()
    send(@name)
    tear_down()
  end

  def setup
  end

  def tear_down
  end
end

class WasRun < TestCase
  attr_reader :was_run, :log
  def setup
    @log = "#{__method__.to_s}"
  end
  def test_method
    @log = "#{@log} #{__method__.to_s}"
  end
  def tear_down
    @log = "#{@log} #{__method__.to_s}"
  end
end

class TestCaseTest < TestCase
  private
    attr_accessor :test
  def test_template_method
    @test = WasRun.new("test_method")
    @test.run()
    raise unless @test.log == "setup test_method tear_down"
  end
end

TestCaseTest.new("test_template_method").run()
