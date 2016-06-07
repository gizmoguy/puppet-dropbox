# Class dropbox::install
class dropbox::install {

  $package_ensure   = $dropbox::package_ensure
  $package_name     = $dropbox::package_name
  $package_provider = $dropbox::package_provider
  $package_source   = $dropbox::real_package_source

  package { 'dropbox':
    ensure   => $package_ensure,
    name     => $package_name,
    provider => $package_provider,
  }

  if $package_source {
    Package['dropbox'] {
      source  => $package_source,
    }
  }

}
