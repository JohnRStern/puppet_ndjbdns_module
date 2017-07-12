# class ndjbdns:packages
#
# Installs ndjbdns. From here, tinydns and dnscache can be set up.
################################################################################

class ndjbdns::packages ($purge=false) {
  if $purge {
    package{'ndjbdns':
      ensure => purged,
    }
  }
  else {
    package{'ndjbdns':
      ensure => installed,
    }
  }
}
