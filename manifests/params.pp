class plexmediaserver::params {
  # Get download URL
  case $::operatingsystem {
    'Darwin': {
      $plex_url = 'http://downloads.plexapp.com/plex-media-server/0.9.9.12.504-3e7f93c/PlexMediaServer-0.9.9.12.504-3e7f93c-OSX.zip'
      $plex_pkg = 'PlexMediaServer-0.9.9.12.504-3e7f93c-OSX.zip'
    }
    'Ubuntu': {
      $plex_url = $::architecture ? {
        'i386'  => 'http://downloads.plexapp.com/plex-media-server/0.9.9.12.504-3e7f93c/plexmediaserver_0.9.9.12.504-3e7f93c_i386.deb',
        default => 'http://downloads.plexapp.com/plex-media-server/0.9.9.12.504-3e7f93c/plexmediaserver_0.9.9.12.504-3e7f93c_amd64.deb',
      }
      $plex_pkg = $::architecture ? {
        'i386'  => 'plexmediaserver_0.9.9.12.504-3e7f93c_i386.deb',
        default => 'plexmediaserver_0.9.9.12.504-3e7f93c_amd64.deb',
      }
    }
    'Fedora': {
      $plex_url = $::architecture ? {
        'i386'  => 'http://downloads.plexapp.com/plex-media-server/0.9.9.12.504-3e7f93c/plexmediaserver-0.9.9.12.504-3e7f93c.i386.rpm',
        default => 'http://downloads.plexapp.com/plex-media-server/0.9.9.12.504-3e7f93c/plexmediaserver-0.9.9.12.504-3e7f93c.x86_64.rpm',
      }
      $plex_pkg = $::architecture ? {
        'i386'  => 'plexmediaserver-0.9.9.12.504-3e7f93c.i386.rpm',
        default => 'plexmediaserver-0.9.9.12.504-3e7f93c.x86_64.rpm',
      }
    }
    'CentOS': {
      $plex_url = $::architecture ? {
        'i386'  => 'http://downloads.plexapp.com/plex-media-server/0.9.9.12.504-3e7f93c/plexmediaserver-0.9.9.12.504-3e7f93c.i386.rpm',
        default => 'http://downloads.plexapp.com/plex-media-server/0.9.9.12.504-3e7f93c/plexmediaserver-0.9.9.12.504-3e7f93c.x86_64.rpm',
      }
      $plex_pkg = $::architecture ? {
        'i386'  => 'plexmediaserver-0.9.9.12.504-3e7f93c.i386.rpm',
        default => 'plexmediaserver-0.9.9.12.504-3e7f93c.x86_64.rpm',
      }
    }
    default: { fail("${::operatingsystem} is not supported by this module.") }
  }
  # Whether or not to manage the staging module
  $plex_staging = false
  # General stuff
  $plex_user                                 = 'plex'
  $plex_media_server_home                    = '/usr/lib/plexmediaserver'
  $plex_media_server_application_support_dir = '`getent passwd $PLEX_USER|awk -F : \'{print $6}\'`/Library/Application Support'
  $plex_media_server_max_plugin_procs        = '6'
  $plex_media_server_max_stack_size          = '10000'
  $plex_media_server_max_lock_mem            = '3000'
  $plex_media_server_max_open_files          = '4096'
  $plex_media_server_tmpdir                  = '/tmp'
}
