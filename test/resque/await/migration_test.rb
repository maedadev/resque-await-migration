require 'test_helper'
require 'resque/await/migration'

class Resque::Await::Migration::Test < ActiveSupport::TestCase
  setup do
    Signal.trap(:USR2) do
      puts "USR2TRAP"
    end
    Signal.trap(:CONT) do
      puts "CONTTRAP"
    end
  end

  test "truth" do
    assert_kind_of Module, Resque::Await::Migration
  end

  test "まだマイグレーションが終わっていない場合、シグナルを受け取ること" do
    ActiveRecord::MigrationContext.any_instance.stubs(:needs_migration?).returns(true, false)

    helper = Resque::Await::Migration::ResqueHelper.new
    assert_output(/USR2TRAP/) { helper.check_migration($$) }
  end

  test "マイグレーションが終わっている場合、シグナルを受け取らないこと" do
    ActiveRecord::MigrationContext.any_instance.stubs(:needs_migration?).returns(false)

    helper = Resque::Await::Migration::ResqueHelper.new
    assert_output(/^(?!.*USR2TRAP).*$/) { helper.check_migration($$) }
  end
end
