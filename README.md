# http_hardening
Puppet module to enable and manage secure http headers.

#### Table of Contents
1. [Overview](#overview)
2. [Description](#description)
3. [Configuration](#configuration)
4. [Usage](#usage)
5. [Notice](#notice)
6. [Contact](#contact)

## <h4>[Overview]</h4>
Puppet module to enable and manage secure http headers.

## <h4>[Description]</h4>
This module provides a easy way to enable and mange secure http headers
on web servers.

## <h4>[Configuration]</h4>
<h5>Standard options available:</h5>
<pre>
<code>
  $apache2                   = boolean &lttrue|false&gt;
  $httpd                     = boolean &lttrue|false&gt;
  $nginx                     = boolean &lttrue|false&gt;
  $lighttpd                  = boolean &lttrue|false&gt;
  $x_frame_options           = 'DENY'
  $x_content_type_options    = 'nosniff'
  $x_xss_protection          = '1; mode=block'
  $content_security_policy   = ''
  $public_key_pins           = ''
  $strict_transport_security = ''
</code>
</pre>
Options relative to secure http headers will soon available on the
<a href="https://github.com/amenezes/http_hardening/wiki">wiki</a>.</br>
For now see:
<a href="https://scotthelme.co.uk/hardening-your-http-response-headers/">securityheaders.io</a> |
in portuguese (pt_BR) see: <a href="https://goo.gl/M9vnpk">here</a>

## <h4>[Usage]</h4>
<h5>Installation</h5>
<pre>
<code>
$ sudo puppet module install amenezes-http_hardening
</code>
</pre>
<h5>Use</h5>
* Basic usage for apache2 (Debian like distros) and
  httpd (RedHat like distros).
  This will enable mod_headers and set some secure http headers.
<pre>
<code>
class { 'http_hardening':
apache2 => true,
}
</code>
</pre>
<pre>
<code>
class { 'http_hardening':
httpd => true,
}
</code>
</pre>
<strong>notice: RedHat (like distros) users eventually
must allow mod_headers on selinux.</strong>

* Basic usage on nginx.
<pre>
<code>
class { 'http_hardening':
nginx => true,
}
</code>
</pre>

</pre>
* Basic usage on lighttpd.
<pre>
<code>
class { 'http_hardening':
lighttpd => true,
}
</code>
</pre>

* Custom configuration on apache2 (Debian like distros)
  or httpd (RedHat like distros).
<pre>
<code>
class { 'http_hardening':
apache2 => true,
x_frame_options  => 'SAMEORIGIN',
x_xss_protection => '1; mode=block',
}
</code>
</pre>
<pre>
<code>
class { 'http_hardening':
httpd => true,
x_frame_options  => 'SAMEORIGIN',
x_xss_protection => '1; mode=block',
}
</code>
</pre>

* Custom configuration on nginx.
<pre>
<code>
class { 'http_hardening':
nginx => true,
x_frame_options  => 'SAMEORIGIN',
x_xss_protection => '1; mode=block',
}
</code>
</pre>

* Custom configuration on lighttpd.
<pre>
<code>
class { 'http_hardening':
lighttpd => true,
x_frame_options  => 'SAMEORIGIN',
x_xss_protection => '1; mode=block',
}
</code>
</pre>

## <h4>[Notice]</h4>
The custom setup to apache2 and httpd is available in beta in this new version
(0.2.4). So, now it's possible enable and manage custom http headers.

Example:
<pre>
<code>
http_hardening::custom_apache { 'custom_config_1':
  custom_param   => 'FilesMatch',
  custom_filter  => '\.(png|ico|jpeg|jpg|gif)$',
  custom_headers => {
    'X-XSS-Protection' => '0',
  }
}

http_hardening::custom_apache { 'custom_config_2':
  custom_filter  => '\.(js|css)$',
  custom_headers => {
    'P3P' => 'CP=\"CAO PSA OUR\"'
  }
}
</code>
</pre>

For more information see: man mod_headers | https://goo.gl/d5B2hm

## <h4>[Contact]</h4>
author: alexandre menezes</br> |
twitter: <a href="https://www.twitter.com/ale_menezes">@ale_menezes</a>
