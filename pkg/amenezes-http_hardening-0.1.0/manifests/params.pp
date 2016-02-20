class http_hardening::params {

  $apache2                        = false
  $nginx                          = false
  $x_frame_options                = 'DENY'
  $x_content_type_options         = 'nosniff'
  $content_security_policy        = ''
  $x_xss_protection               = '1; mode=block'

}
