class plexmediaserver::service {
  service { 'plexmediaserver':
    ensure    => running,
    enable    => true,
  }
}
