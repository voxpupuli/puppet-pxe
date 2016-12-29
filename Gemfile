source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.8.0'
  gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem "puppetlabs_spec_helper"
  gem 'json', '~>1.0' if RUBY_VERSION == '1.9.3'
  gem 'json_pure', '~>1.0' if RUBY_VERSION == '1.9.3'
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "beaker"
  gem "beaker-rspec"
  gem "vagrant-wrapper"
  gem "puppet-blacksmith"
  gem "guard-rake"
end
