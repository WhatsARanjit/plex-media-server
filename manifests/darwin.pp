class plexmediaserver::darwin ($source, $package){
  $service_provider = 'launchd'
  $package_target   = "/tmp/${package}"

  staging::deploy { $package:
    source => $source,
    target => $package_target,
    before => Package['plexmediaserver'],
  }
}
