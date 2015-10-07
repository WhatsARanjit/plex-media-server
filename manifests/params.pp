class plexmediaserver::params {
  # Set Plex version
  $plex_version = '0.9.12.13.1464-4ccd2ca'

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
      $plex_config = '/etc/default/plexmediaserver'
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
      $plex_config   = '/etc/sysconfig/PlexMediaServer'
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
      $plex_config   = '/etc/sysconfig/PlexMediaServer'
    }
    default: { fail("${::operatingsystem} is not supported by this module.") }
  }
  # Whether or not to manage the staging module
  $plex_staging = false
  # General stuff
  $plex_user                                       = 'plex'
  $plex_media_server_home                          = '/usr/lib/plexmediaserver'
  $plex_media_server_application_support_dir = '${HOME}/Library/Application Support'
  $plex_media_server_max_plugin_procs        = '6'
  $plex_media_server_max_stack_size          = '3000'
  $plex_media_server_max_lock_mem            = '3000'
  $plex_media_server_max_open_files          = '4096'
  $plex_media_server_tmpdir                  = '/tmp'
}
