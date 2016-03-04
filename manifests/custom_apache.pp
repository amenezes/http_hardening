# Class: http_hardening::custom_apache
#
# This class manage custom_apache http headers in
# instances of RedHat and Debian like distros.
#
# Parameters:
# => local params (not modified)
#
# - $package represents custom_apache service name
#
# - $headers represents the name of file with secure http
#   headers configuration
#
# - headers_dir represents the base directory configuration
#   of $headers file#
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

  if $::apache2 == false {
    fail('[*] Configuration not supported.')
  } elsif $::httpd == false {
    fail('[*] Configuration not supported.')
  }

  case $::osfamily {
    'redhat': {
      $package     = 'httpd'
      $headers     = 'custom-headers.conf'
      $headers_dir = "/etc/${package}/conf.d"
    }
    'debian': {
      $package     = 'apache2'
      $headers     = 'custom-headers.conf'
      $headers_dir = "/etc/${package}/conf-enabled"
    }
    default: {
      fail("[*] Unsupported osfamily ${::osfamily}")
    }
  }

  concat::fragment { "frag_${name}":
    target  => "${headers_dir}/${headers}",
    content => template('http_hardening/custom_apache.conf.erb'),
  }
#  file { $headers:
#    ensure  => file,
#    path    => "${headers_dir}/${headers}",
#    content => template('http_hardening/custom_apache.conf.erb'),
#    notify  => Class['::http_hardening::service'],
#  }

}
