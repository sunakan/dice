module Worldcup2014
  DATABASE_YAML = Rails.root.join("config", "ext_databases", "worldcup2014_database.yml").freeze
  # DB自体を変更しているのでテーブル名にprefixはいらない
  #  def self.table_name_prefix
  #    'everyday_rails_rspec_'
  #  end
  #def self.table_name_prefix
  #  'worldcup2014_'
  #end
  class AppRecord < ApplicationRecord
    databases = YAML.load_file(DATABASE_YAML)
    establish_connection(databases[Rails.env])
    self.abstract_class = true
  end
end
