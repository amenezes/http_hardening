# Class: http_hardening::httpd
#
# This class manage secure headers on httpd
# instance in RedHat like distros.
#
# Parameters:
# - $package represents httpd service name
#
# - $headers_dir represents the base directory configuration
#   of $conf_headers_file
#
# => other Parameters see http_hardening::params class
#
# Actions:
#   - Enable and manage secure http headers on httpd instance
#
class http_hardening::httpd {

  include http_hardening

  case $::osfamily {
    'redhat': {
      $package     = 'httpd'
      $headers_dir = "/etc/${package}/conf.d"
    }
    default: {
      fail("[*] Unsupported osfamily ${::osfamily}")
    }
  }

  $x_content_type_options     = $http_hardening::x_content_type_options
  $x_frame_options            = $http_hardening::x_frame_options
  $x_xss_protection           = $http_hardening::x_xss_protection
  $content_security_policy    = $http_hardening::content_security_policy
  $public_key_pins            = $http_hardening::public_key_pins
  $strict_transport_security  = $http_hardening::strict_transport_security
  $conf_headers_file          = $http_hardening::conf_headers_file
  $conf_custom_headers_file   = $http_hardening::conf_custom_headers_file

  file { $conf_headers_file:
    ensure  => file,
    path    => "${headers_dir}/${conf_headers_file}",
    content => template("http_hardening/apache_${conf_headers_file}.erb"),
    notify  => Class['::http_hardening::service'],
  }

  class { '::http_hardening::service':
    package => $package,
  }

  concat { "${headers_dir}/${conf_custom_headers_file}":
    ensure => present,
    path   => "${headers_dir}/${conf_custom_headers_file}",
    notify => Class['::http_hardening::service'],
  }

}
