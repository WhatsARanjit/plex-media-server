class plexmediaserver (
  $plex_version                              =
    $plexmediaserver::params::plex_version,
  $plex_url                                  =
    $plexmediaserver::params::plex_url,
  $plex_pkg                                  =
    $plexmediaserver::params::plex_pkg,
  $plex_provider                             =
    $plexmediaserver::params::plex_provider,
  $plex_user                                 =
    $plexmediaserver::params::plex_user,
  $plex_media_server_home                    =
    $plexmediaserver::params::plex_media_server_home,
  $plex_media_server_application_support_dir =
    $plexmediaserver::params::plex_media_server_application_support_dir,
  $plex_media_server_max_plugin_procs        =
    $plexmediaserver::params::plex_media_server_max_plugin_procs,
  $plex_media_server_max_stack_size          =
    $plexmediaserver::params::plex_media_server_max_stack_size,
  $plex_media_server_max_lock_mem            =
    $plexmediaserver::params::plex_media_server_max_lock_mem,
  $plex_media_server_max_open_files          =
    $plexmediaserver::params::plex_media_server_max_open_files,
  $plex_media_server_tmpdir                  =
    $plexmediaserver::params::plex_media_server_tmpdir
) inherits plexmediaserver::params {
  case $::operatingsystem {
    'Darwin': {
      staging::deploy { $plex_pkg:
        source => $plex_url,
        target => '/tmp',
        before => Package['plexmediaserver'],
      }
    }
    default: {
      staging::file { $plex_pkg:
        source => $plex_url,
        target => "/tmp/${plex_pkg}",
        before => Package['plexmediaserver'],
      }
    }
  }
  Package {
    ensure => installed,
  }
  if $::operatingsystem == 'ubuntu' {
    $packages = ['libavahi-common-data','libavahi-common3','avahi-utils',$plexmediaserver::params::plex_ubuntu_deps]
    ensure_packages($packages)
  }
  package { 'plexmediaserver':
    provider => $plex_provider,
    source   => "/tmp/${plex_pkg}",
    ensure   => 'latest',
  }
  if $plexmediaserver::params::plex_config {
    file { 'plexconfig':
      ensure  => file,
      path    => $plexmediaserver::params::plex_config,
      owner   => 'root',
      group   => 'root',
      mode    => '0775',
      content => template("${module_name}/PlexMediaServer.erb"),
      require => Package['plexmediaserver'],
    }
  }
  $subscription_file = $plexmediaserver::params::plex_config ? {
    undef   => undef,
    default => File['plexconfig'],
  }
  service { 'plexmediaserver':
    ensure    => running,
    enable    => true,
    subscribe => $subscription_file,
  }
}
