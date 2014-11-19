source 'https://rubygems.org'

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

gem 'rake',                   :require => false
gem 'puppetlabs_spec_helper', :require => false
gem 'puppet-syntax',          :require => false
gem 'rspec',                   '<3.0.0'
gem 'rspec-expectations',      '<3.0.0'
gem 'rspec-puppet',           :require => false
gem 'rspec-core', '~> 2.0',   :require => false
