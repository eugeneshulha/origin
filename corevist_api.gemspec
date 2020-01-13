$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'corevist_api/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'corevist_api'
  spec.description = 'Rails REST API of Corevist core application'
  spec.authors     = ['Oleg Ryzhko', 'Yury Matusevich']
  spec.email       = %w(oleg.ryzhko@corevist.com yury.a.matusevich@gmail.com)

  spec.homepage    = 'https://www.corevist.com/'
  spec.summary     = 'Corevist Core Engine REST API'

  spec.test_files  = Dir['spec/**/*']
  spec.files       = Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md']
  spec.version     = CorevistAPI::VERSION

  spec.add_dependency 'rails',          '~> 5.2.4'
  spec.add_dependency 'mysql2',         '~> 0.5.2'
  spec.add_dependency 'unicorn',        '~> 5.5.1'
  spec.add_dependency 'devise',         '~> 4.7.1'
  spec.add_dependency 'devise-jwt',     '~> 0.5.9'
  spec.add_dependency 'rack-cors',      '~> 1.1.0'
  spec.add_dependency 'jbuilder',       '~> 2.9.1'

  spec.add_development_dependency 'pry-byebug'
end
