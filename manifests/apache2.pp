# Class: http_hardening::apache2
#
# This class manage secure http headers on apache2
# instance in Debian like distros.
#
# Parameters:
# - $package represents apache2 service name
#
# - $base_file represents main apache2 configuration file
#
# - $base_dir  represents apache2 base configuration directory
#
# - $headers_dir represents the base directory
#   configuration of $headers file
#
# => other Parameters see http_hardening::params class
#
# Actions:
#   - Enable and manage secure http headers on apache2 instance
#
class http_hardening::apache2 {

  include http_hardening

  case $::osfamily {
    'debian': {
      $package     = 'apache2'
      $base_file   = "${package}.conf"
      $base_dir    = "/etc/${package}"
      $headers_dir = "${base_dir}/conf-enabled"
    }
    default: {
      fail("[*] Unsupported osfamily ${::osfamily}")
    }
  }

  $x_frame_options                     = $http_hardening::x_frame_options
  $x_content_type_options              = $http_hardening::x_content_type_options
  $x_xss_protection                    = $http_hardening::x_xss_protection
  $x_robots_tag                        = $http_hardening::x_robots_tag
  $public_key_pins                     = $http_hardening::public_key_pins
  $strict_transport_security           = $http_hardening::strict_transport_security
  $content_security_policy             = $http_hardening::content_security_policy
  $content_security_policy_report_only = $http_hardening::content_security_policy_report_only
  $x_content_security_policy           = $http_hardening::x_content_security_policy
  $x_webkit_csp                        = $http_hardening::x_webkit_csp
  $conf_headers_file                   = $http_hardening::conf_headers_file
  $conf_custom_headers_file            = $http_hardening::conf_custom_headers_file

  file { $conf_headers_file:
    ensure  => file,
    path    => "${headers_dir}/${conf_headers_file}",
    content => template("http_hardening/apache_${conf_headers_file}.erb"),
    notify  => Class['::http_hardening::service'],
  }->
  file_line { "${base_dir}/${base_file}":
    path => "${base_dir}/${base_file}",
    line => "Include ${headers_dir}/*.conf",
  }

  exec { "enable_${package}":
    command => '/usr/sbin/a2enmod headers',
    before  => File[$conf_headers_file],
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
