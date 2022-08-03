require 'bundler/setup'
require 'bundler/gem_tasks'

# Test Tasks
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test


# DB Setup And DB Tasks
require_relative "./test/active_record_setting"
Test::ActiveRecordSetting.database_tasks_setting(ENV['RAILS_ENV'] || 'development')

task :environment do
  Test::ActiveRecordSetting.establish_connection(ENV['RAILS_ENV'] || 'development')
end

load 'active_record/railties/databases.rake'
