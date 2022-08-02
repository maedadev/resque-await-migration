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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'rake'
  spec.add_dependency "activerecord", '>= 5.2.0', '< 7.2.0'
  spec.add_dependency "railties", '>= 5.2.0', '< 7.2.0'

  spec.add_development_dependency 'rails', '>= 5.2.0', '< 7.2.0'
  spec.add_development_dependency 'resque'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'mocha'
end
