source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.6'
# Declare your gem's dependencies in corevist_api.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

gem 'sapnwrfc',                          git: 'git@github.com:b2b2dot0/sapnwrfc.git'
# Pull in extra gems to run specs against the gem.
#

group :test, :development do
  gem 'pry-byebug'
  gem 'thin'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec-html-matchers'
  gem 'rspec-rails'
  gem 'shoulda', require: false
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
end
