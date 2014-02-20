class plexmediaserver::service (
  $plex_user                                 = $plexmediaserver::params::plex_user,
  $plex_media_server_home                    = $plexmediaserver::params::plex_media_server_home,
  $plex_media_server_application_support_dir = $plexmediaserver::params::plex_media_server_application_support_dir,
  $plex_media_server_max_plugin_procs        = $plexmediaserver::params::plex_media_server_max_plugin_procs,
  $plex_media_server_max_stack_size          = $plexmediaserver::params::plex_media_server_max_stack_size,
  $plex_media_server_max_lock_mem            = $plexmediaserver::params::plex_media_server_max_lock_mem,
  $plex_media_server_max_open_files          = $plexmediaserver::params::plex_media_server_max_open_files,
  $plex_media_server_tmpdir                  = $plexmediaserver::params::plex_media_server_tmpdir
){
  service { 'plexmediaserver':
    ensure => running,
    enable => true,
  }
  file { '/etc/sysconfig/PlexMediaServer':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/PlexMediaServer.erb"),
    notify  => Service['plexmediaserver'],
  }
}
