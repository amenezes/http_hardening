# Class: http_hardening::nginx
#
# This class manage secure http headers on nginx instance.
#
# Parameters:
# - $package represents nginx service name
#
# - $headers_dir represents the base directory configuration
#   of $conf_headers_file
#
# => other Parameters see http_hardening::params class
#
# Actions:
#   - Enable and manage secure http headers on nginx instance
#
class http_hardening::nginx {

  include http_hardening

  $package                    = 'nginx'
  $headers_dir                = "/etc/${package}/conf.d"
  $conf_headers_file          = $http_hardening::conf_headers_file
  $x_content_type_options     = $http_hardening::x_content_type_options
  $x_frame_options            = $http_hardening::x_frame_options
  $x_xss_protection           = $http_hardening::x_xss_protection
  $content_security_policy    = $http_hardening::content_security_policy
  $public_key_pins            = $http_hardening::public_key_pins
  $strict_transport_security  = $http_hardening::strict_transport_security

  case $::osfamily {
    /^(Debian|RedHat)$/:{
      file { $conf_headers_file:
        ensure  => file,
        path    => "${headers_dir}/${conf_headers_file}",
        content => template("http_hardening/${package}_${conf_headers_file}.erb"),
        notify  => Class['::http_hardening::service'],
      }

      class { '::http_hardening::service':
        package => $package,
      }
    }
    default: {
      fail("[*] Unsupported osfamily ${::osfamily}")
    }

  }

}
