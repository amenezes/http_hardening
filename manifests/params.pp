class http_hardening::params {

  $apache2                        = false
  $httpd                          = false
  $nginx                          = false
  $x_frame_options                = 'DENY'
  $x_content_type_options         = 'nosniff'
  $content_security_policy        = ''
  $x_xss_protection               = '1; mode=block'
  $public_key_pins                = ''
  $strict_transport_security      = ''

}
