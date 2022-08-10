require 'active_record'
require 'resque'

module Resque
  module Await
    module Migration

      class Controller
        class << self

          def start

            return unless (ActiveRecord::Base.connection rescue false)
            return unless ActiveRecord::Base.connection.migration_context.needs_migration?

            parent_pid = Process.pid
            @_child_pid = fork { self.check_in_forked(parent_pid) }
            @_thread = Process.detach(@_child_pid)
          end

          def stop_if_alive
            if @_thread && @_thread.alive?
              Process.kill(:KILL, @_child_pid)
            end
          end

          def check_in_forked(parent_pid)

            interval         = ENV['INTERVAL']&.to_i || 5
            timeout_limit    = ENV['AWAIT_MIGRATION_LIMIT']&.to_i || 60 * 60 # 60 minutes
            usr2_was_sent_at = Time.now.to_i

            _info_log "Migration is needed. Send signal:USR2 to PID:#{parent_pid}"
            Process.kill(:USR2, parent_pid)

            begin
              while ActiveRecord::Base.connection.migration_context.needs_migration?
                sleep interval

                if Time.now.to_i - usr2_was_sent_at > timeout_limit
                  _info_log "Time limit for awaiting migration has been exceeded. LIMIT:#{timeout_limit}"
                  _info_log "So, abort resque worker."

                  _info_log "Send signal:TERM to PID:#{parent_pid}"
                  Process.kill(:TERM, parent_pid)
                  return
                end
              end
              _info_log "Migration has finished. Send signal:CONT to PID:#{parent_pid}"
              Process.kill(:CONT, parent_pid)

            rescue => e
              _info_log "Caught Error: #{e}\n" + e.backtrace.join("\n")
              _info_log "Send signal:CONT to PID:#{parent_pid}"
              Process.kill(:CONT, parent_pid)
            end
          end

          def _info_log(msg)
            Resque.logger.info msg
          end
        end
      end

    end
  end
end
