
namespace :resque_await_migration do
  desc "マイグレーションチェックする処理を実行します"
  task :check_migration => :environment  do
    pid = ENV['ORIGIN_PID']
    helper = Resque::Await::Migration::ResqueHelper.new
    helper.check_migration(pid)
  end

  task :beforeJob => :environment  do
    puts "バックグラウンド処理を実行します"
    sh "ORIGIN_PID=#{$$} bundle exec rake resque_await_migration:check_migration &"
    puts "バックグラウンド処理を実行しました"
  end
end

Rake::Task[:'resque:work'].enhance([:'resque_await_migration:beforeJob'])
