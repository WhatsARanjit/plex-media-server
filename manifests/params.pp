class plexmediaserver::params {
  $plex_user                                 = 'plex'
  $plex_media_server_home                    = '/usr/lib/plexmediaserver'
  $plex_media_server_application_support_dir = "`getent passwd $plex_user|awk -F : '{print $6}'`/Library/Application Support"
  $plex_media_server_max_plugin_procs        = '6'
  $plex_media_server_max_stack_size          = '10000'
  $plex_media_server_max_lock_mem            = '3000'
  $plex_media_server_max_open_files          = '4096'
  $plex_media_server_tmpdir                  = '/tmp'
}
