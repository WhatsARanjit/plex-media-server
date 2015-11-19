require 'spec_helper'

describe 'plexmediaserver', :type => :class do
  context "on all operating systems" do
    let :facts do
    {
      :operatingsystem => 'CentOS',
    }
    end
    it { should contain_class('plexmediaserver') }
    it { should contain_file('plexconfig') }
    it { should contain_service('plexmediaserver').with(
      'ensure' => 'running'
    ) }
  end

  context "without custom parameters" do
    let :facts do
    {
      :operatingsystem => 'CentOS',
    }
    end
    it { should contain_file('plexconfig').with_content %r{^PLEX_USER=plex$} }
    it { should contain_file('plexconfig').with_content %r{^PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver$} }
  end

  context "with custom parameters" do
    let :facts do
    {
      :operatingsystem => 'CentOS',
    }
    end
    let :params do
    {
      :plex_media_server_max_plugin_procs => '7',
      :plex_media_server_max_stack_size   => '20000'
    }
    end
    it { should contain_file('plexconfig').with_content %r{^PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=7$} }
    it { should contain_file('plexconfig').with_content %r{^PLEX_MEDIA_SERVER_MAX_STACK_SIZE=20000$} }
  end

  context "on a CentOS 32-bit system" do
    let :facts do
    {
      :operatingsystem => 'CentOS',
      :architecture    => 'i386',
    }
    end
    it { should contain_staging__file('plexmediaserver-0.9.12.19.1537-f38ac80.i386.rpm') }
  end

  context "on a CentOS 64-bit system" do

    let :facts do
    {
      :operatingsystem => 'CentOS',
      :architecture    => 'x86_64',
    }
    end
    it { should contain_staging__file('plexmediaserver-0.9.12.19.1537-f38ac80.x86_64.rpm') }
  end

  context "on a Darwin system" do

    let :facts do
    {
      :operatingsystem => 'Darwin',
    }
    end
    it { should contain_staging__deploy('PlexMediaServer-0.9.12.19.1537-f38ac80-OSX.zip') }
  end

  context "on a Ubuntu 32-bit system" do
    let :facts do
    {
      :operatingsystem => 'Ubuntu',
      :architecture    => 'i386',
    }
    end
    it { should contain_staging__file('plexmediaserver_0.9.12.19.1537-f38ac80_i386.deb') }
  end

  context "on a Ubuntu 64-bit system" do

    let :facts do
    {
      :operatingsystem => 'Ubuntu',
      :architecture    => 'amd64',
    }
    end
    it { should contain_staging__file('plexmediaserver_0.9.12.19.1537-f38ac80_amd64.deb') }
  end

end
