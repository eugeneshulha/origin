$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "corevist_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "corevist_api"
  spec.version     = CorevistApi::VERSION
  spec.authors     = ["Oleg Ryzhko"]
  spec.email       = ["oleg.ryzhko@corevist.com"]
  spec.homepage    = "https://www.corevist.com/"
  spec.summary     = "Corevist Core Engine API"
  spec.description = "B2B E-Commerce platform"
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

  spec.add_dependency "rails", "~> 5.2.4", ">= 5.2.4.1"

  spec.add_development_dependency "mysql2"
end
