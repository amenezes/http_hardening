# Class: http_hardening::service
#
# This class manage instances of web server.
#
# Parameters:
# - $package represents web server name
#
# Actions:
#   - Restarts web server instance
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
