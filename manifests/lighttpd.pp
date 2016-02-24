# Class: http_hardening::lighttpd
#
# This class manage secure headers on lighttpd instance.
#
# Parameters:
# => local params (not modified)
# - $package represents lighttpd service name
#
#- $headers represents the name of file with secure http
#   headers configuration
#
# - headers_dir represents the base directory configuration
#   of $headers file
#
# => other Parameters see http_hardening::params class
#
# Actions:
#   - enabled and manage secure headers on lighttpd instance
#
class http_hardening::lighttpd {

  include http_hardening

  case $::osfamily {
    /^(Debian|RedHat)$/: {
      $package            = 'lighttpd'
      $headers            = 'headers.conf'
      $conf_enabled_dir   = "/etc/${package}/conf-enabled"
      $conf_available_dir = "/etc/${package}/conf-available"
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }

  $x_content_type_options     = $http_hardening::x_content_type_options
  $x_frame_options            = $http_hardening::x_frame_options
  $x_xss_protection           = $http_hardening::x_xss_protection
  $content_security_policy    = $http_hardening::content_security_policy
  $public_key_pins            = $http_hardening::params::public_key_pins
  $strict_transport_security  = $http_hardening::params::strict_transport_security

  validate_string($x_content_type_options)
  validate_string($x_frame_options)
  validate_string($x_xss_protection)
  validate_string($content_security_policy)
  validate_string($public_key_pins)
  validate_string($strict_transport_security)

  file { $headers:
    ensure  => file,
    path    => "${conf_available_dir}/15-${headers}",
    content => template("http_hardening/${package}-${headers}.erb"),
    notify  => File["${conf_enabled_dir}/${headers}"],
  }

  file { "${conf_enabled_dir}/${headers}":
    ensure => link,
    target => "${conf_available_dir}/15-${headers}",
    notify => Service[$package],
  }

  service { $package:
    ensure  => running,
    restart => '',
  }

}
