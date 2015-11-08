class plexmediaserver::config inherits plexmediaserver::params {
  if $plexmediaserver::params::plex_config {
    file { 'plexconfig':
      ensure  => file,
      path    => $plexmediaserver::params::plex_config,
      owner   => 'root',
      group   => 'root',
      mode    => '0775',
      content => template("${module_name}/PlexMediaServer.erb"),
    }
  }
}
