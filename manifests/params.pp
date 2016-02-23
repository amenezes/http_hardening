# Class: http_hardening::params
#
# This class manages Apache parameters
#
# Parameters:
# - The $apache2 represents option to enable and mange
#   secure headers on Debian like distros
# - The $httpd represents option to enable and mange
#   secure headers on RedHat like distros
# - The $nginx represents option to enable and manage
#   secure headers on nginx
# - The $x_frame_options
# - The $x_content_type_options
# - The $content_security_policy
# - The $x_xss_protection
# - The $public_key_pins
# - The $strict_transport_security
#
# Actions:
#
#
class http_hardening::params {

  $apache2                   = false
  $httpd                     = false
  $nginx                     = false
  $x_frame_options           = 'DENY'
  $x_content_type_options    = 'nosniff'
  $content_security_policy   = ''
  $x_xss_protection          = '1; mode=block'
  $public_key_pins           = ''
  $strict_transport_security = ''

}
