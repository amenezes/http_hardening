# Class: http_hardening
#
# This class manage the inclusion of secure http headers in
# web servers supported.
#
# Parameters:
# => see http_hardening::params class
#
# Actions:
#   - Manage the inclusion of secure http headers on:
#   * apache2 / httpd
#   * nginx
#   * lighttpd
#
class http_hardening (
  $apache2                             = $::http_hardening::params::apache2,
  $nginx                               = $::http_hardening::params::nginx,
  $httpd                               = $::http_hardening::params::httpd,
  $lighttpd                            = $::http_hardening::params::lighttpd,
  $x_frame_options                     = $::http_hardening::params::x_frame_options,
  $x_content_type_options              = $::http_hardening::params::x_content_type_options,
  $x_xss_protection                    = $::http_hardening::params::x_xss_protection,
  $x_robots_tag                        = $::http_hardening::params::x_robots_tag,
  $public_key_pins                     = $::http_hardening::params::public_key_pins,
  $strict_transport_security           = $::http_hardening::params::strict_transport_security,
  $content_security_policy             = $::http_hardening::params::content_security_policy,
  $content_security_policy_report_only = $::http_hardening::params::content_security_policy_report_only,
  $x_content_security_policy           = $::http_hardening::params::x_content_security_policy,
  $x_webkit_csp                        = $::http_hardening::params::x_webkit_csp,
  $conf_headers_file                   = $::http_hardening::params::conf_headers_file,
  $conf_custom_headers_file            = $::http_hardening::params::conf_custom_headers_file,
) inherits http_hardening::params {

  validate_bool($apache2)
  validate_bool($nginx)
  validate_bool($httpd)
  validate_bool($lighttpd)
  validate_string($x_frame_options)
  validate_string($x_content_type_options)
  validate_string($x_xss_protection)
  validate_string($x_robots_tag)
  validate_string($public_key_pins)
  validate_string($strict_transport_security)
  validate_string($content_security_policy)
  validate_string($content_security_policy_report_only)
  validate_string($x_content_security_policy)
  validate_string($x_webkit_csp)
  validate_string($conf_headers_file)
  validate_string($conf_custom_headers_file)

  if $apache2 {
    include ::http_hardening::apache2
  }
  elsif $httpd {
    include ::http_hardening::httpd
  }
  elsif $nginx {
    include ::http_hardening::nginx
  }
  elsif $lighttpd {
    include ::http_hardening::lighttpd
  }
  else {
    fail('[*] web server not supported!')
  }

}
