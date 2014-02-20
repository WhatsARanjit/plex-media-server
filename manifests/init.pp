class plexmediaserver {
  class { 'plexmediaserver::yum': }
  class { 'plexmediaserver::install':
    require => Class['plexmediaserver::yum'],
  }
  class { 'plexmediaserver::service':
    require => Class['plexmediaserver::install'],
  }
}
