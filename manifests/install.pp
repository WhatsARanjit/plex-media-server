class plexmediaserver::install inherits plexmediaserver {
  # Get download URL
  case $::operatingsystem {
    'Darwin': {
      $plex_url      = "https://downloads.plex.tv/plex-media-server/${plex_version}/PlexMediaServer-${plex_version}-OSX.zip"
      $plex_pkg      = "PlexMediaServer-${plex_version}-OSX.zip"
      $plex_provider = 'pkgdmg'
    }
    'Ubuntu': {
      case $::architecture {
        'i386': {
          $plex_url = "https://downloads.plex.tv/plex-media-server/${plex_version}/plexmediaserver_${plex_version}_i386.deb"
          $plex_pkg = "plexmediaserver_${plex_version}_i386.deb"
        }
        default : {
          $plex_url = "https://downloads.plex.tv/plex-media-server/${plex_version}/plexmediaserver_${plex_version}_amd64.deb"
          $plex_pkg = "plexmediaserver_${plex_version}_amd64.deb"
        }
      }
      $plex_provider = 'dpkg'
      $plex_ubuntu_deps = [ 'libavahi-core7', 'libdaemon0', 'avahi-daemon' ]
    }
    'Fedora': {
      case $::architecture {
        'i386': {
          $plex_url = "https://downloads.plex.tv/plex-media-server/${plex_version}/plexmediaserver-${plex_version}.i386.rpm"
          $plex_pkg = "plexmediaserver-${plex_version}.i386.rpm"
        }
        default : {
          $plex_url = "https://downloads.plex.tv/plex-media-server/${plex_version}/plexmediaserver-${plex_version}.x86_64.rpm"
          $plex_pkg = "plexmediaserver-${plex_version}.x86_64.rpm"
        }
      }
      $plex_provider = 'rpm'
    }
    'CentOS': {
      case $::architecture {
        'i386': {
          $plex_url = "https://downloads.plex.tv/plex-media-server/${plex_version}/plexmediaserver-${plex_version}.i386.rpm"
          $plex_pkg = "plexmediaserver-${plex_version}.i386.rpm"
        }
        default : {
          $plex_url = "https://downloads.plex.tv/plex-media-server/${plex_version}/plexmediaserver-${plex_version}.x86_64.rpm"
          $plex_pkg = "plexmediaserver-${plex_version}.x86_64.rpm"
        }
      }
      $plex_provider = 'rpm'
    }
    default: { fail("${::operatingsystem} is not supported by this module.") }
  }
  # install packages
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
  if $::operatingsystem == 'ubuntu' {
    $packages = ['libavahi-common-data','libavahi-common3','avahi-utils',$plex_ubuntu_deps]
    ensure_packages($packages)
  }
  package { 'plexmediaserver':
    provider => $plex_provider,
    source   => "/tmp/${plex_pkg}",
    ensure   => 'latest',
  }
}
