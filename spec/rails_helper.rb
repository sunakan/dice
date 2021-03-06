require "simplecov_helper"
require "spec_helper"

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "shoulda/matchers"

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:active_record].strategy = :truncation
    DatabaseCleaner[:active_record, model: Paiza::AppRecord].strategy = :truncation
    # DatabaseCleaner[:active_record, model: Worldcup2014::AppRecord].strategy = :truncation
    # DatabaseCleaner[:active_record, model: EverydayRailsRspec::AppRecord].strategy = :truncation
    load(Rails.root.join("db", "worldcup2014", "seeds.rb"))
  end
  config.before do
    DatabaseCleaner[:mongoid].start
    DatabaseCleaner[:active_record].start
    DatabaseCleaner[:active_record, model: Paiza::AppRecord].start
    # DatabaseCleaner[:active_record, model: Worldcup2014::AppRecord].start
    # DatabaseCleaner[:active_record, model: EverydayRailsRspec::AppRecord].start
  end
  config.after do
    DatabaseCleaner[:mongoid].clean
    DatabaseCleaner[:active_record].clean
    DatabaseCleaner[:active_record, model: Paiza::AppRecord].clean
    # DatabaseCleaner[:active_record, model: Worldcup2014::AppRecord].clean
    # DatabaseCleaner[:active_record, model: EverydayRailsRspec::AppRecord].clean
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
