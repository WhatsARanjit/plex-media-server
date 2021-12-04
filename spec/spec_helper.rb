require 'puppetlabs_spec_helper/module_spec_helper'

require 'rspec-puppet'
require 'rspec-puppet-utils'

require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /plex.tv/)
       .with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'})
       .to_return(
         status: 301,
         headers: {
           location: 'https://plex.tv/downloads/plexmediaserver_latest_version-hash_amd64.deb'
         })
  end
end
