# Define: http_hardening::custom_lighttpd
#
# This class manage custom_lighttpd http headers in
# instances of RedHat and Debian like distros.
#
# Parameters:
# - $custom_filter represents the filter option to apply custom http
#   header set in $custom_headers
#
# - $custom_headers represents the custom http headers to apply
#   in a specific context
#
# - $package represents apache2 or httpd service name
#
# - $conf_custom_headers_file represents the default file
#   of custom secure http headers
#
# - $headers_dir represents the base directory
#   configuration of $headers file
#
# - $target_concat represents the resource target
#
# => other Parameters see http_hardening::params class
#
# Actions:
#   - Enable and manage custom http headers on lighttpd instance
#
define http_hardening::custom_lighttpd (
  $custom_filter  = '\.(png|ico|jpeg|jpg|gif)$',
  $custom_headers = {
    '' => '',
  }
) {

  include http_hardening

  $package                  = 'lighttpd'
  $conf_custom_headers_file = $http_hardening::conf_custom_headers_file

  validate_string($conf_custom_headers_file)
  validate_string($custom_filter)
  validate_hash($custom_headers)

  case $::osfamily {
    'redhat': {
      $headers_dir   = "/etc/${package}/conf.d"
      $target_concat = "${headers_dir}/${conf_custom_headers_file}"
    }
    'debian': {
      $headers_dir   = "/etc/${package}/conf-available"
      $target_concat = "${headers_dir}/15-${conf_custom_headers_file}"
    }
    default: {
      fail("[*] Unsupported osfamily ${::osfamily}")
    }
  }

  concat::fragment { "frag_${name}":
    target  => $target_concat,
    content => template('http_hardening/custom_lighttpd.conf.erb'),
  }

}
