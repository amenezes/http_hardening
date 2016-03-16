### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Usage](#usage)  
 3.1. [Installation](#installation)  
 3.2. [Use](#use)
4. [Custom Headers](#custom-headers)
5. [Contact](#contact)

### 1. Overview  <a id="overview"></a>
---
Puppet module to enable, configure and manage secure http headers on web servers.

### 2. Module Description <a id="module-description"></a>
---
This module provides a easy way to enable, configure and mange secure
http headers on:
 - apache2 (debian like distros);
 - httpd (redhat like distros);
 - nginx;
 - lighttpd.

Standard options available are:
<pre>
<code>
   $x_frame_options           = 'DENY'
   $x_content_type_options    = 'nosniff'
   $x_xss_protection          = '1; mode=block'
   $content_security_policy   = ''
   $public_key_pins           = ''
   $strict_transport_security = ''
</code>
</pre>
Options relative to secure http headers will soon available on the [wiki][1].  
For now see: [securityheaders.io][2] (en_US) and in portuguese (pt_BR) see:
[here][3]

### 3. Usage <a id="usage"></a>
---
#### Installation <a id="installation"></a>
<pre>
<code>
$ sudo puppet module install amenezes-http_hardening
</code>
</pre>
#### Use <a id="use"></a>
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
> **note: RedHat (like distros) users eventually
must allow mod_headers on selinux.**

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
> **note: mod_setenv need be enabled.**

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

### 4. Custom Headers <a id="custom-headers"></a>

* Custom HTTP Headers configuration on apache2 or httpd.
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

For more information see: man [mod_headers][4]


* Custom HTTP Headers configuration on lighttpd.
<pre>
<code>
http_hardening::custom_lighttpd { 'custom_config_1':
  custom_headers => {
    'X-XSS-Protection' => '0',
  }
}

http_hardening::custom_lighttpd { 'custom_config_2':
  custom_filter  => '\.(js|css)$',
  custom_headers => {
    'P3P' => 'CP=\"CAO PSA OUR\"'
  }
}
</code>
</pre>

### 5. Contact <a id="contact"></a>
author: alexandre menezes | twitter: [@ale_menezes][5]

[1]:https://github.com/amenezes/http_hardening/wiki
[2]:https://scotthelme.co.uk/hardening-your-http-response-headers/
[3]:https://goo.gl/M9vnpk
[4]:https://goo.gl/d5B2hm
[5]:https://www.twitter.com/ale_menezes
