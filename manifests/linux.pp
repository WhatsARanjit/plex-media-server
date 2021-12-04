class plexmediaserver::linux ($source, $package){
  $service_provider  = 'systemd'
  $package_target    = "/tmp/${package}"

  case $::operatingsystem {
    'Ubuntu': {
      $plex_ubuntu_deps = [ 'libavahi-core7', 'libdaemon0', 'avahi-daemon' ]
      $plex_config      = '/etc/default/plexmediaserver'
    }
    'Fedora': {
      $plex_config   = '/etc/sysconfig/PlexMediaServer'
    }
    'CentOS': {
      $plex_config   = '/etc/sysconfig/PlexMediaServer'
    }
    default: { fail("${::operatingsystem} is not supported by this module.") }
  }

  staging::file { $package:
    source => $source,
    target => $package_target,
    before => Package['plexmediaserver'],
  }

  Package {
    ensure => installed,
  }
  if $::operatingsystem == 'Ubuntu' {
    package { 'libavahi-common-data': }
    -> package { 'libavahi-common3': }
    -> package { 'avahi-utils': }
    -> package { $plex_ubuntu_deps:
      before => Package['plexmediaserver'],
    }
  }
}
