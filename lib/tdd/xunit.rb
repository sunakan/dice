class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run
    result = TestResult.new()
    result.test_started()
    setup()
    send(@name)
    tear_down()
    return result
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
  def test_broken_method
    raise Exception
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

  def test_result
    @test = WasRun.new("test_method")
    result = @test.run()
    raise unless result.summary() == "1 run, 0 failed"
  end

  def test_failed_result
    @test = WasRun.new("test_broken_method")
    result = @test.run()
    raise unless result.summary() == "1 run, 1 failed"
  end
end

class TestResult
  private
    attr_accessor :run_count
  public
  def initialize
    @run_count = 0
  end

  def test_started
    @run_count += 1
  end

  def summary
    "#{@run_count} run, 0 failed"
  end
end

TestCaseTest.new("test_template_method").run()
TestCaseTest.new("test_result").run()
#TestCaseTest.new("test_failed_result").run()
