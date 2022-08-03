module Resque
  module Await
    module Migration

      class ResqueHelper
        def check_migration(pid)
          if ActiveRecord::Base.connection.migration_context.needs_migration?
            puts "kill -USR2 #{pid} を実行します"
            system "kill -USR2 #{pid}"
          else
            puts "マイグレーションチェックする処理を実行しました"
            return
          end
          begin
            loop do
              unless ActiveRecord::Base.connection.migration_context.needs_migration?
                break
              end
              sleep 30
            end
          rescue => e
            puts "例外が発生しました: #{e}"
          ensure
            puts "kill -CONT #{pid} を実行します"
            system "kill -CONT #{pid}"
            puts "マイグレーションチェックする処理を実行しました"
          end
        end
      end

    end
  end
end
