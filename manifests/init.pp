# class ndjbdns
#
# Bootstraps dbndns onto the node, which is good enough to provide
# dnsip and friends. Doesn't set up dnscache or tinydns; use their respective
# subclasses for that.

class ndjbdns ($purge=false, $purge_logs=false) {
  include ndjbdns::params
  class { 'ndjbdns::packages':
    purge => $purge,
  }
#  class { 'ndjbdns::users':
#    purge => $purge,
#  }
  if $purge {
    if $purge_logs {
      file { '/var/log/ndjbdns':
        ensure  => absent,
        purge   => true,
        recurse => true,
        force   => true,
      }
    }
  }
  else {
    file { '/var/log/ndjbdns':
      ensure => directory,
      mode   => '0755',
    }
  }
}
