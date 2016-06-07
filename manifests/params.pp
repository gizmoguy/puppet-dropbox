# Class dropbox::params
class dropbox::params {

  case $::osfamily {
    'Debian': {
      $package_ensure   = 'installed'
      $package_name     = 'dropbox'
      $package_provider = 'apt'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  #install
  $package_apt_pin  = ''
  $repos_ensure     = true

}
