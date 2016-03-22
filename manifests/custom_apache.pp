# Define: http_hardening::custom_apache
#
# This class manage custom_apache http headers in
# instances of RedHat and Debian like distros.
#
# Parameters:
# - $custom_param represents the custom context to apply $custom_filter
#
# - $custom_filter represents the filter option to apply custom http
#   header set in $custom_headers
#
# - $custom_headers represents the custom http headers to apply
#   in a specific context
#
# - $conf_custom_headers_file represents the default file
#   of custom secure http headers
#
# - $package represents apache2 or httpd service name
#
# - $headers_dir represents the base directory
#   configuration of $headers file
#
# => other Parameters see http_hardening::params class
#
# Actions:
#   - Enable and manage custom http headers on htttpd or apache 2 instance
#
define http_hardening::custom_apache (
  $custom_param   = 'FilesMatch',
  $custom_filter  = '\.(png|ico|jpeg|jpg|gif)$',
  $custom_headers = {
    '' => '',
  }
) {

  include http_hardening

  $conf_custom_headers_file = $http_hardening::conf_custom_headers_file

  validate_string($custom_param)
  validate_string($custom_filter)
  validate_hash($custom_headers)

  case $::osfamily {
    'redhat': {
      $package     = 'httpd'
      $headers_dir = "/etc/${package}/conf.d"
    }
    'debian': {
      $package     = 'apache2'
      $headers_dir = "/etc/${package}/conf-enabled"
    }
    default: {
      fail("[*] Unsupported osfamily ${::osfamily}")
    }
  }

  concat::fragment { "frag_${name}":
    target  => "${headers_dir}/${conf_custom_headers_file}",
    content => template('http_hardening/custom_apache.conf.erb'),
  }

}
