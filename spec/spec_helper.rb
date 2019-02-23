require "simplecov"

SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # :suite => RSpecの実行時に1度だけ実行
  # :each  => 各example毎に実行
  # 順番
  # before :suite
  # before :context
  # before :example
  # after  :example
  # after  :context
  # after  :suite
  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:active_record].strategy = :truncation
  end
  config.before do
    DatabaseCleaner[:mongoid].start
    DatabaseCleaner[:active_record].start
  end
  config.after do
    DatabaseCleaner[:mongoid].clean
    DatabaseCleaner[:active_record].clean
  end
end
