# Class: http_hardening::service
#
# This class manage instances of web server.
#
# Parameters:
# => local params (not modified)
# - $package represents service service name
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
#   - Restart web server instance
#
class http_hardening::service (
  $package = undef,
) {

  if $package == undef {
    fail('[*] A valid package name must be set!')
  } else {
    service { $package:
      ensure     => running,
      hasrestart => true,
      hasstatus  => true,
    }
  }

}
