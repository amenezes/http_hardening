class http_hardening (
  $apache2                        = $::http_hardening::params::apache2,
  $nginx                          = $::http_hardening::params::nginx,
  $x_frame_options                = $::http_hardening::params::x_frame_options,
  $x_content_type_options         = $::http_hardening::params::x_content_type_options,
  $content_security_policy        = $::http_hardening::params::content_security_policy,
  $x_xss_protection               = $::http_hardening::params::x_xss_protection,
  $public_key_pins                = $::http_hardening::params::public_key_pins,
  $strict_transport_security      = $::http_hardening::params::strict_transport_security,
) inherits http_hardening::params {

  if $apache2 {
    validate_bool($apache2)
    include ::http_hardening::apache2
  }
  elsif $nginx {
    validate_bool($nginx)
    fail("[*] web server not supported yet.")
  }
  else {
    fail('[*] web server not supported!')
  }

}
