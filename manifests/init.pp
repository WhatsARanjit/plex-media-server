class plexmediaserver (
  $plex_url                                  = $plexmediaserver::params::plex_url,
  $plex_pkg                                  = $plexmediaserver::params::plex_pkg,
  $plex_user                                 = $plexmediaserver::params::plex_user,
  $plex_media_server_home                    = $plexmediaserver::params::plex_media_server_home,
  $plex_media_server_application_support_dir = $plexmediaserver::params::plex_media_server_application_support_dir,
  $plex_media_server_max_plugin_procs        = $plexmediaserver::params::plex_media_server_max_plugin_procs,
  $plex_media_server_max_stack_size          = $plexmediaserver::params::plex_media_server_max_stack_size,
  $plex_media_server_max_lock_mem            = $plexmediaserver::params::plex_media_server_max_lock_mem,
  $plex_media_server_max_open_files          = $plexmediaserver::params::plex_media_server_max_open_files,
  $plex_media_server_tmpdir                  = $plexmediaserver::params::plex_media_server_tmpdir
) inherits plexmediaserver::params {
  case $::operatingsystem {
    'Darwin': { 
      staging::deploy { $plex_pkg:
        source => $plex_url,
        target => "/tmp",
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
  package { 'plexmediaserver':
    ensure   => installed,
    provider => 'rpm',
    source   => "/tmp/${plex_pkg}",
  }
  file { 'plexconfig':
    ensure  => file,
    path    => '/etc/sysconfig/PlexMediaServer',
    owner   => 'root',
    group   => 'root',
    mode    => '0775',
    content => template("${module_name}/PlexMediaServer.erb"),
    require => Package['plexmediaserver'],
  }
  service { 'plexmediaserver':
    ensure    => running,
    enable    => true,
    subscribe => File['plexconfig'],
  }
}
