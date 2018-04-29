source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6'
# Use postgres as the database
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use Redis adapter for cacheing and in-memory storage
gem 'redis', '~> 4.0'
# Use figaro for environment variables
gem 'figaro'

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Use rspec-rails for testing
  gem 'rspec-rails'
  # Use database cleaner to manage database state when running specs
  gem 'database_cleaner'
  # Use factory_bot for testing
  gem 'factory_bot_rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
