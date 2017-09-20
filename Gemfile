source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_GEM_VERSION'] || '~> 4.5.1'
  gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem "puppetlabs_spec_helper"
  gem "metadata-json-lint", '~>1.1.0' if RUBY_VERSION == '1.9.3'
  gem "rspec-puppet-facts"
  gem 'json', '~>1.0' if RUBY_VERSION == '1.9.3'
  gem 'json_pure', '~>1.0' if RUBY_VERSION == '1.9.3'
end

group :development do
  gem "travis"
  gem "travis-lint"
end

group :release do
  gem "puppet-blacksmith"
end
