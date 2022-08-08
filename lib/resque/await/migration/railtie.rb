module Resque
  module Await
    module Migration
      class Railtie < ::Rails::Railtie
        rake_tasks do
          load 'tasks/check_migration.rake'
        end
      end
    end
  end
end
