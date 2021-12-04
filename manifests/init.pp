class plexmediaserver (
  $plex_provider                             =
    $plexmediaserver::params::plex_provider,
  $plex_url                                  =
    $plexmediaserver::params::plex_url,
  $plex_pkg                                  =
    $plexmediaserver::params::plex_pkg,
  $plex_user                                 =
    $plexmediaserver::params::plex_user,
  $plex_install_latest                       =
    $plexmediaserver::params::plex_install_latest,
  $plex_media_server_home                    =
    $plexmediaserver::params::plex_media_server_home,
  $plex_media_server_application_support_dir =
    $plexmediaserver::params::plex_media_server_application_support_dir,
  $plex_media_server_max_plugin_procs        =
    $plexmediaserver::params::plex_media_server_max_plugin_procs,
  $plex_media_server_max_stack_size          =
    $plexmediaserver::params::plex_media_server_max_stack_size,
  $plex_media_server_max_lock_mem            =
    $plexmediaserver::params::plex_media_server_max_lock_mem,
  $plex_media_server_max_open_files          =
    $plexmediaserver::params::plex_media_server_max_open_files,
  $plex_media_server_tmpdir                  =
    $plexmediaserver::params::plex_media_server_tmpdir
) inherits plexmediaserver::params {

  $plex_installer = $::operatingsystem ? {
    'Darwin' => 'plexmediaserver::darwin',
    default  => 'plexmediaserver::linux',
  }

  if ($plex_install_latest) {
    # Fetch latest version from plex website
    $plex_latest = latest_version($::osfamily)
    notice("Automatically selecting latest plex package: ${plex_latest['pkg']}")
    class { $plex_installer:
      package => $plex_latest['pkg'],
      source  => "${plex_latest['url']}/${plex_latest['pkg']}",
    }
  } else {
    class { $plex_installer:
      package => $plex_pkg,
      source  => "${plex_url}/${plex_pkg}",
    }
  }

  package { 'plexmediaserver':
    ensure   => installed,
    provider => $plex_provider,
    source   => getvar("${plex_installer}::pkg_target"),
    require  => Class[$plex_installer],
  }

  $plex_config = getvar("${plex_installer}::plex_config")

  if $plex_config {
    file { 'plexconfig':
      ensure  => file,
      path    => $plex_config,
      owner   => 'root',
      group   => 'root',
      mode    => '0775',
      content => template("${module_name}/PlexMediaServer.erb"),
      require => Package['plexmediaserver'],
      notify  => Service['plexmediaserver']
    }
  }

  service { 'plexmediaserver':
    ensure   => running,
    enable   => true,
    provider => getvar("${plex_installer}::service_provider"),
  }
}
