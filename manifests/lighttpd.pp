# Class: http_hardening::lighttpd
#
# This class manage secure http headers on lighttpd instance.
#
# Parameters:
# - $package represents lighttpd service name
#
# - $conf_enabled_dir represents the link or include necessary to configure,
#   secure http headers
#
# - $conf_available_dir represents the path of file with secure http headers.
#
# - $concat_name represents the resource name of concat file
#
# => other Parameters see http_hardening::params class
#
# Actions:
#   - enabled and manage secure http headers on lighttpd instance
#
class http_hardening::lighttpd {

  include http_hardening

  $package                             = 'lighttpd'
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

  case $::osfamily {
    'debian': {
      $conf_enabled_dir   = "/etc/${package}/conf-enabled"
      $conf_available_dir = "/etc/${package}/conf-available"
      $concat_name        = "${conf_available_dir}/15-${conf_custom_headers_file}"
      $mod_setenv_config  = "/etc/${package}/${package}.conf"

      file { $conf_headers_file:
        ensure  => file,
        path    => "${conf_available_dir}/15-${conf_headers_file}",
        content => template("http_hardening/${package}_${conf_headers_file}.erb"),
        notify  => File["${conf_enabled_dir}/${conf_headers_file}"],
      }

      file { "${conf_enabled_dir}/${conf_headers_file}":
        ensure => link,
        target => "${conf_available_dir}/15-${conf_headers_file}",
        notify => File["${conf_enabled_dir}/${conf_custom_headers_file}"],
      }

      file { "${conf_enabled_dir}/${conf_custom_headers_file}":
        ensure => link,
        target => $concat_name,
        notify => Class['::http_hardening::service'],
      }
    }
    'redhat': {
      $conf_enabled_dir   = "/etc/${package}/modules.conf"
      $conf_available_dir = "/etc/${package}/conf.d"
      $concat_name        = "${conf_available_dir}/${conf_custom_headers_file}"
      $mod_setenv_config  = $conf_enabled_dir

      file { $conf_headers_file:
        ensure  => file,
        path    => "${conf_available_dir}/${conf_headers_file}",
        content => template("http_hardening/${package}_${conf_headers_file}.erb"),
        notify  => Class['::http_hardening::service'],
      }->
      file_line { 'include_headers':
        ensure => present,
        path   => $conf_enabled_dir,
        line   => "include \"conf.d/${conf_headers_file}\"",
      }->
      file_line { 'include_custom_headers':
        ensure => present,
        path   => $conf_enabled_dir,
        line   => "include \"conf.d/${conf_custom_headers_file}\"",
      }
    }
    default: {
      fail("[*] Unsupported osfamily ${::osfamily}")
    }
  }

  file_line { 'enable_mod_setenv':
    ensure => present,
    path   => $mod_setenv_config,
    line   => "\t\"mod_setenv\",",
    after  => 'server.modules',
  }

  concat { $concat_name:
    ensure => present,
    path   => $concat_name,
    notify => Class['::http_hardening::service'],
  }

  class { '::http_hardening::service':
    package => $package,
  }
}
