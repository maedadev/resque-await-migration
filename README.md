# Resque::Await::Migration

This is a Resque Plugin that allows the Resque Worker to wait until the ActiveRecord's migration has done.

## Installation & Usage

Add this line to your application's Gemfile:

```ruby
gem 'resque-await-migration'
```

Just do this, your application's Resque Worker will wait for the migration to complete.

## How it works

Resque::Await::Migration monitors whether ActiveRecord migration has been applied or not in a child process.

The child process is forked from the ResqueWorker process in the before_first_fork hook of Resque.
And, terminated when it is confirmed that the migration has been applied.

### Monitoring

If the migration has not yet been applied, it sends a USR2 signal to the Resque Worker to stop the process.
When the migration has been applied, it sends a CONT signal and resumes processing.

The monitoring interval and time limit can be specified by the following environment variables.

* INTERVAL ... monitoring interval seconds. default: 5(sec)
* AWAIT_MIGRATION_LIMIT ... Time limit waiting for migration to be applied. default: 3600(sec)

### Logging

The execution log is output to Resque.logger.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
