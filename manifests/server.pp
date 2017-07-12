#
class ndjbdns::server (

  $ensure      = present,
  $authoritative_port = 1053,
  $port        = 53,
  $soa_name    = $::fqdn,
  $soa_mail    = undef
) {

  include ::stdlib

  # Input validation
  ##############################################################################

  validate_string($password)
  validate_integer($port)
  validate_integer($authoritative_port`)

  # Apply actions
  ##############################################################################

  if $ensure == 'present' {
    class { ndjbdns::server::authoritative :
      ensure      => present,
      address     => '127.0.0.1',
      port        => $authoritative_port,
      soa_name    => $soa_name,
      soa_mail    => $soa_mail
    }
    # Create an array of any zones being managed by the authoritative nameserver.
    $zones = suffix(pdns_zonelist("http://${ipaddress}:${api_port}", $password), "=127.0.0.1:${authoritative_port}")

    class { ndjbdns::server::recursive :
      ensure          => present,
      address         => '0.0.0.0',
      port            => $port,
      forwarded_zones => $zones
    }
  } else {
    class { ndjbdns::server::authoritative : ensure => absent }
    class { ndjbdns::server::recursive : ensure => absent }
  }
}
