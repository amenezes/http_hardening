# Class: http_hardening::apache2
#
# This class manage secure headers on apache2
# instance in Debian like distros.
#
# Parameters:
# => local params (not modified)
# - $package represents apache2 service name
#
# - $base_file represents main apache2 configuration file
#
# - $base_dir  represents apache2 base configuration directory
#
# - $headers represents the name of file with
#   secure http headers configuration
#
# - headers_dir represents the base directory
#   configuration of $headers file
#
# => other Parameters see http_hardening::params class
#
# Actions:
#   - Enable and manage secure headers on apache2 instance
#
class http_hardening::apache2 {

  include http_hardening

  case $::osfamily {
    'debian': {
      $package     = 'apache2'
      $base_file   = "${package}.conf"
      $base_dir    = "/etc/${package}"
      $headers     = 'headers.conf'
      $headers_dir = "${base_dir}/conf-enabled"
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
    path    => "${headers_dir}/${headers}",
    content => template("http_hardening/apache-${headers}.erb"),
    notify  => Service[$package],
  }->
  file_line { "${base_dir}/${base_file}":
    path => "${base_dir}/${base_file}",
    line => "Include ${headers_dir}/${headers}",
  }

  exec { "enable-${package}":
    command => '/usr/sbin/a2enmod headers',
    before  => File[$headers],
  }

  service { $package:
    ensure  => running,
    restart => '',
  }
}
