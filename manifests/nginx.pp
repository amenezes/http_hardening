class http_hardening::nginx {

  include http_hardening

 # common params
  $package             = 'nginx'
  $headers             = 'headers.conf'
  $headers_dir         = "/etc/${package}/conf.d"

  case $::osfamily {
    'redhat': {
      $srv_restart_command = "/usr/bin/systemctl restart ${package}"
    }
    'debian': {
      $srv_restart_command = "/usr/bin/service ${package} restart"
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }

  $x_content_type_options     = "${http_hardening::x_content_type_options}"
  $x_frame_options            = "${http_hardening::x_frame_options}"
  $x_xss_protection           = "${http_hardening::x_xss_protection}"
  $content_security_policy    = "${http_hardening::content_security_policy}"
  $public_key_pins            = "${http_hardening::params::public_key_pins}"
  $strict_transport_security  = "${http_hardening::params::strict_transport_security}"

  validate_string($x_content_type_options)
  validate_string($x_frame_options)
  validate_string($x_xss_protection)
  validate_string($content_security_policy)
  validate_string($public_key_pins)
  validate_string($strict_transport_security)

  file { "${headers}":
    ensure    => file,
    path      => "${headers_dir}/${headers}",
    content   => template("http_hardening/${package}-${headers}.erb"),
    notify    => Exec['restart'],
  }

  exec { 'restart':
    command   => $srv_restart_command,
  }
}
