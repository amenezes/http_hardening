# Class: http_hardening::nginx
#
# This class manage secure http headers on nginx instance.
#
# Parameters:
# => local params (not modified)
# - $package represents nginx service name
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
#   - Enable and manage secure http headers on nginx instance
#
class http_hardening::nginx {

  include http_hardening

  $package                    = 'nginx'
  $headers                    = 'headers.conf'
  $headers_dir                = "/etc/${package}/conf.d"
  $x_content_type_options     = $http_hardening::x_content_type_options
  $x_frame_options            = $http_hardening::x_frame_options
  $x_xss_protection           = $http_hardening::x_xss_protection
  $content_security_policy    = $http_hardening::content_security_policy
  $public_key_pins            = $http_hardening::public_key_pins
  $strict_transport_security  = $http_hardening::strict_transport_security

  validate_string($x_content_type_options)
  validate_string($x_frame_options)
  validate_string($x_xss_protection)
  validate_string($content_security_policy)
  validate_string($public_key_pins)
  validate_string($strict_transport_security)

  case $::osfamily {
    /^(Debian|RedHat)$/:{
      file { $headers:
        ensure  => file,
        path    => "${headers_dir}/${headers}",
        content => template("http_hardening/${package}_${headers}.erb"),
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
