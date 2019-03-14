class TestCase
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def run(result)
    result.test_started()
    setup()
    begin
      send(@name)
    rescue
      result.test_failed()
    end
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
  def test_broken_method
    raise
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

  def test_failed_result_formatting
    result = TestResult.new()
    result.test_started()
    result.test_failed()
    raise unless result.summary() == "1 run, 1 failed"
  end

  def test_suite
    suite = TestSuite.new()
    suite.add(WasRun.new("test_method"))
    suite.add(WasRun.new("test_broken_method"))
    result = TestResult.new()
    suite.run(result)
    raise unless result.summary() == "2 run, 1 failed"
  end
end

class TestResult
  private
    attr_accessor :run_count, :error_count
  public
  def initialize
    @run_count   = 0
    @error_count = 0
  end

  def test_started
    @run_count += 1
  end

  def test_failed
    @error_count += 1
  end

  def summary
    "#{@run_count} run, #{@error_count} failed"
  end
end

class TestSuite
  private
    attr_accessor :tests
  public
  def initialize
    @tests = []
  end

  def add(test)
    @tests.push(test)
  end

  def run(result)
    @tests.each do |test|
      test.run(result)
    end
  end
end

suite = TestSuite.new()
suite.add(TestCaseTest.new("test_template_method"))
suite.add(TestCaseTest.new("test_result"))
suite.add(TestCaseTest.new("test_failed_result"))
suite.add(TestCaseTest.new("test_failed_result_formatting"))
suite.add(TestCaseTest.new("test_suite"))
result = TestResult.new()
suite.run(result)
puts result.summary()
