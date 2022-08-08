$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "resque/await/migration/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "resque-await-migration"
  spec.version     = Resque::Await::Migration::VERSION
  spec.authors     = ["bizside-developers"]
  spec.email       = ["bizside-developers@lab.acs-jp.com"]
  spec.homepage    = "https://github.com/maedadev/resque-await-migration"
  spec.summary     = "resque await migration"
  spec.description = "add rake task for resque to await DB migration of activerecord"
  spec.license     = "MIT"

  spec.files = Dir["{lib}/**/*", "MIT-LICENSE", "README.md"]

  spec.add_dependency "resque"
  spec.add_dependency "activerecord", '>= 5.2.0', '< 7.2.0'

  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'rake'
end
