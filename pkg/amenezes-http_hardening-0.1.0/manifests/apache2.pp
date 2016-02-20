class http_hardening::apache2 {

  include http_hardening

  case $::osfamily {
    'debian': {
      $package   = 'apache2'
      $base_file = "${package}.conf"
      $base_dir  = "/etc/${package}"
      $headers   = 'headers.conf'
      $headers_dir = "${base_dir}/conf-enabled"
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }

  $x_content_type_options   = "${http_hardening::x_content_type_options}"
  $x_frame_options          = "${http_hardening::x_frame_options}"
  $x_xss_protection         = "${http_hardening::x_xss_protection}"
  $content_security_policy  = "${http_hardening::content_security_policy}"

  validate_string($x_content_type_options)
  validate_string($x_frame_options)
  validate_string($x_xss_protection)
  validate_string($content_security_policy)

  file { "${headers}":
    ensure  => file,
    path    => "${headers_dir}/${headers}",
    content => template("http_hardening/${headers}.erb"),
    notify  => Exec['restart'],
  }->
  file_line { "${base_dir}/${base_file}":
    path    => "${base_dir}/${base_file}",
    line    => "Include ${headers_dir}/${headers}",
  }

  exec { "enable-${package}":
    command => '/usr/sbin/a2enmod headers',
    before  => File["${headers}"],
  }

  exec { 'restart':
    command => "/usr/sbin/service $package restart",
    require => Exec["enable-${package}"],
  }
}
