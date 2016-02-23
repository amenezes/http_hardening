# Class: http_hardening::params
#
# This class manages Apache parameters
#
# Parameters:
# - The $apache2 represents option to enable and manage
#   secure headers on Debian like distros
# - The $httpd represents option to enable and manage
#   secure headers on RedHat like distros
# - The $nginx represents option to enable and manage
#   secure headers on nginx
# - The $x_frame_options tells the browser whether you
#   want to allow your site to be framed or not.
#   By preventing a browser from framing your site you
#   can defend against attacks like clickjacking.
# - The $x_content_type_options stops a browser from
#   trying to MIME-sniff the content type and forces it
#   to stick with the declared content-type. This helps
#   to reduce the danger of drive-by downloads.
#   The only valid value for this header is "nosniff".
# - The $content_security_policy is an effective measure
#   to protect your site from XSS attacks. By whitelisting
#   sources of approved content, you can prevent the browser
#   from loading malicious assets.
# - The $x_xss_protection sets the configuration for
#   the cross-site scripting filters built into most browsers.
#   The best configuration is "X-XSS-Protection: 1; mode=block".
# - The $public_key_pins extension for HTTP (HPKP) is a security
#   header that tells a web client to associate a specific
#   cryptographic public key with a certain web server to prevent
#   MITM attacks with forged certificates.
# - The $strict_transport_security (HSTS) enforces secure
#   (HTTP over SSL/TLS) connections to the server.
#   This reduces impact of bugs in web applications leaking
#   session data through cookies and external links and defends
#   against Man-in-the-middle attacks. HSTS also disables the
#   ability for user's to ignore SSL negotiation warnings.
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
