class plexmediaserver (
  $plex_user                                 = $plexmediaserver::params::plex_user,
  $plex_media_server_home                    = $plexmediaserver::params::plex_media_server_home,
  $plex_media_server_application_support_dir = $plexmediaserver::params::plex_media_server_application_support_dir,
  $plex_media_server_max_plugin_procs        = $plexmediaserver::params::plex_media_server_max_plugin_procs,
  $plex_media_server_max_stack_size          = $plexmediaserver::params::plex_media_server_max_stack_size,
  $plex_media_server_max_lock_mem            = $plexmediaserver::params::plex_media_server_max_lock_mem,
  $plex_media_server_max_open_files          = $plexmediaserver::params::plex_media_server_max_open_files,
  $plex_media_server_tmpdir                  = $plexmediaserver::params::plex_media_server_tmpdir
) inherits plexmediaserver::params {
  yumrepo { 'plexrepo':
    baseurl  => 'http://plex.r.worldssl.net/PlexMediaServer/fedora-repo/release/$basearch/',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'http://plexapp.com/plex_pub_key.pub',
  }
  package { 'plexmediaserver':
    ensure  => installed,
  }
  file { 'plexconfig':
    ensure  => file,
    path    => '/etc/sysconfig/PlexMediaServer',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/PlexMediaServer.erb"),
  }
  service { 'plexmediaserver':
    ensure => running,
    enable => true,
  }
  Yumrepo['plexrepo'] -> Package['plexmediaserver'] -> File['plexconfig'] ~> Service['plexmediaserver']
}
