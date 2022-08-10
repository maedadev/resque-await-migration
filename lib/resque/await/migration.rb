require "resque"
require 'resque/await/migration/controller'

module Resque
  module Await
    module Migration

      def setup
        Resque.before_first_fork do
          Resque::Await::Migration::Controller.start
        end

        if Resque.respond_to?(:worker_exit)
          Resque.worker_exit do
            Resque::Await::Migration::Controller.stop_if_alive
          end
        else
          Kernel.at_exit do
            Resque::Await::Migration::Controller.stop_if_alive
          end
        end
      end
      module_function :setup

    end
  end
end

Resque::Await::Migration.setup
