# External DB用を作成したり、スキーマ定義する作業を楽にするためのrakeタスク
#
# rake ext_db:create RAILS_ENV=..
# rake ext_db:drop   RAILS_ENV=..
# rake ext_db:ridgepole:apply RAILS_ENV=..
#
namespace :ext_db do
  desc "複数DB用 db:create (config/ext_databases/*_database.yml)"
  task :create do
    Dir.glob(Rails.root.join("config", "ext_databases", "*_database.yml")) do |yml_file|
      config = YAML.load_file(yml_file)[Rails.env]
      next if config.blank?

      ActiveRecord::Tasks::DatabaseTasks.create!(config)
    end
  end
  desc "複数DB用 db:drop (config/ext_databases/*_database.yml)"
  task :drop do
    Dir.glob(Rails.root.join("config", "ext_databases", "*_database.yml")) do |config_file|
      config = YAML.load_file(config_file)[Rails.env]
      next if config.blank?

      ActiveRecord::Tasks::DatabaseTasks.drop(config)
    end
  end

  namespace :ridgepole do
    desc "複数DB用の ridgepole --apply (config/ext_databases/*_database.ymlとdb/*/Schemafile)"
    task :apply do
      Dir.glob(Rails.root.join("config", "ext_databases", "*_database.yml")) do |config_file|
        base_db_name = Pathname(config_file).basename.to_s.match(/\A(.*)_database.yml\z/)[1]
        schema_file = Rails.root.join("db", base_db_name, "Schemafile").to_s
        command = "bundle exec ridgepole -c #{config_file} -E #{Rails.env} --apply -f #{schema_file}"
        system command
      end
    end
  end
end
