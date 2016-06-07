# class dropbox::repo::apt
# requires
#   puppetlabs-apt
#   puppetlabs-stdlib
class dropbox::repo::apt(
  $location    = undef,
  $release     = $::lsbdistcodename,
  $repos       = 'main',
  $include_src = false,
  $key         = '1C61A2656FB57B7E4DE0F4C1FC918B335044912E',
  $key_content = template("${module_name}/repo.pub.key.erb"),
  ) {

  $pin = $dropbox::package_apt_pin

  if !$location {
    $os = downcase($::operatingsystem)
    $_location  = "http://linux.dropbox.com/${os}"
  } else {
    $_location = $location
  }

  Class['dropbox::repo::apt'] -> Package<| title == 'dropbox' |>

  $ensure_source = $dropbox::repos_ensure ? {
    false   => 'absent',
    default => 'present',
  }

  apt::source { 'dropbox':
    ensure      => $ensure_source,
    location    => $_location,
    release     => $release,
    repos       => $repos,
    include_src => $include_src,
    key         => $key,
    key_content => $key_content,
  }

  if $pin != '' {
    validate_re($pin, '\d\d\d')
    apt::pin { 'dropbox':
      packages => 'dropbox',
      priority => $pin,
    }
  }
}
