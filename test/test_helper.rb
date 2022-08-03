require 'active_support/test_case'
require 'active_support/testing/autorun'
require 'mocha/minitest'

require_relative "./active_record_setting"
Test::ActiveRecordSetting.establish_connection("test")
