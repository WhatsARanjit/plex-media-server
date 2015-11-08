class plexmediaserver::params {
  # Whether or not to manage the staging module
  $plex_staging = false

  # General stuff
  $plex_user                                 = 'plex'
  $plex_media_server_home                    = '/usr/lib/plexmediaserver'
  $plex_media_server_application_support_dir = '${HOME}/Library/Application Support'
  $plex_media_server_max_plugin_procs        = '6'
  $plex_media_server_max_stack_size          = '3000'
  $plex_media_server_max_lock_mem            = '3000'
  $plex_media_server_max_open_files          = '4096'
  $plex_media_server_tmpdir                  = '/tmp'

  case $::operatingsystem {
    'Ubuntu': {
      $plex_config = '/etc/default/plexmediaserver'
    }
    'Fedora': {
      $plex_config = '/etc/sysconfig/PlexMediaServer'
    }
    'CentOS': {
      $plex_config = '/etc/sysconfig/PlexMediaServer'
    }
  }
}
