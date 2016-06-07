# Class dropbox::config
class dropbox::config {
  case $::osfamily {
    'Debian': {
      file { '/etc/default/dropbox-repo':
        ensure  => file,
        mode    => '0644',
        owner   => '0',
        group   => '0',
      }
    }
    default: {
    }
  }
}
