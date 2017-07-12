# class ndjbdns::params
#
# This class is meant to be called from ndjbdns.
# It sets variables according to platform.
#

class ndjbdns::params {

  # Default git branch to pull from
  $git_revision   = 'master'

  case $::osfamily {
    'RedHat': {
      $systemd   = '/usr/lib/systemd/system'
      $dnsroots_path       = '/etc/ndjbdns/servers/roots'
    }
    'Centos': {
      $systemd   = '/usr/lib/systemd/system'
      $dnsroots_path       = '/etc/ndjbdns/servers/roots'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
