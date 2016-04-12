class { 'http_hardening':
  lighttpd => true,
}
http_hardening::custom_lighttpd { 'custom_config_1':
  custom_param   => 'FilesMatch',
  custom_filter  => '.(png|ico|jpeg|jpg|gif)$',
  custom_headers => {
  'X-XSS-Protection' => '0',
  }
}
http_hardening::custom_lighttpd { 'custom_config_2':
  custom_param   => 'FilesMatch',
  custom_filter  => '.(doc|pdf|docx)$',
  custom_headers => {
  'X-Robots-Tag' => 'noindex,nofollow',
  }
}
