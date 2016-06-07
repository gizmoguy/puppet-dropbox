# Class: dropbox
# ===========================
#
# Puppet module for installing linux dropbox client.
#
# Examples
# --------
#
# @example
#    class { 'dropbox':
#    }
#
# Authors
# -------
#
# Brad Cowie <brad@wand.net.nz>
#
# Copyright
# ---------
#
# Copyright 2016 Brad Cowie, unless otherwise noted.
#
class dropbox(
  $package_apt_pin  = $dropbox::params::package_apt_pin,
  $package_ensure   = $dropbox::params::package_ensure,
  $package_name     = $dropbox::params::package_name,
  $package_provider = $dropbox::params::package_provider,
  $package_source   = undef,
  $repos_ensure     = $dropbox::params::repos_ensure,
  $repo_key         = undef,
  $repo_key_content = undef,
) inherits dropbox::params {

  validate_re($package_apt_pin, '^(|\d+)$')
  validate_string($package_ensure)
  validate_string($package_name)
  validate_string($package_provider)
  validate_string($package_source)
  validate_bool($repos_ensure)
  validate_string($repo_key)

  include '::dropbox::install'
  include '::dropbox::config'

  if $manage_repos != false {
    case $::osfamily {
      'Debian': {
        class { '::dropbox::repo::apt' :
          key         => $repo_key,
          key_content => $repo_key_content,
        }
      }
      default:
        { }
    }
  }

  anchor { 'dropbox::begin': }
  anchor { 'dropbox::end': }

  Anchor['dropbox::begin'] -> Class['::dropbox::config']
    -> Class['::dropbox::install'] -> Anchor['dropbox::end']

}
