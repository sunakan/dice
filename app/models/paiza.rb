module Paiza
  DATABASE_YAML = Rails.root.join("config", "ext_databases", "paiza_database.yml").freeze

  class AppRecord < ApplicationRecord
    databases = YAML.load_file(DATABASE_YAML)
    establish_connection(databases[Rails.env])
    self.abstract_class = true
  end
end
