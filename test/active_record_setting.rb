require 'active_record'

module Test
  class ActiveRecordSetting
    class << self
      def root_dir
        File.join(File.dirname(__FILE__), '..')
      end

      def database_yml_hash
        YAML::load(File.read(File.join(root_dir, 'config', 'database.yml')))
      end

      def establish_connection(rails_env)
        ActiveRecord::Base.configurations = database_yml_hash
        ActiveRecord::Base.establish_connection rails_env.to_sym
      end

      def database_tasks_setting(rails_env)
        ActiveRecord::Tasks::DatabaseTasks.env = rails_env
        ActiveRecord::Tasks::DatabaseTasks.db_dir = File.join(root_dir, 'db')
        ActiveRecord::Tasks::DatabaseTasks.database_configuration = database_yml_hash
        ActiveRecord::Tasks::DatabaseTasks.migrations_paths = File.join(root_dir, 'db', 'migrate')
      end
    end
  end
end

ActiveRecord::Migrator.migrations_paths = [
  File.join(Test::ActiveRecordSetting.root_dir, 'db', 'migrate')
]
