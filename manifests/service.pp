class plexmediaserver::service {
  service { 'plexmediaserver':
    ensure => running,
    enable => true,
  }
  file { '/etc/sysconfig/PlexMediaServer':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/${module_name}/PlexMediaServer",
    notify => Service['plexmediaserver'],
  }
}
