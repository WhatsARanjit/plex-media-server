class plexmediaserver::yum {
  yumrepo { 'plexrepo':
    baseurl  => 'http://plex.r.worldssl.net/PlexMediaServer/fedora-repo/release/$basearch/',
    enabled  => 1,
    gpgcheck => 1,
    notify   => Exec['plex-key-import'],
  }
  exec { 'plex-key-import':
    command     => '/bin/rpm --import http://plexapp.com/plex_pub_key.pub',
    refreshonly => true,
  }
}

