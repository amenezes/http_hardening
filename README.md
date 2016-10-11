### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Usage](#usage)  
 - [Installation](#installation)  
 - [Use](#use)
4. [Custom Headers](#custom-headers)
5. [Contact](#contact)

### 1. Overview  <a id="overview"></a>
---
Puppet module to enable, configure and manage secure http headers on web servers.

### 2. Module Description <a id="module-description"></a>
---
This module provides an easy way to enable, configure and manage secure
http headers on:
 - apache2 (debian like distros);
 - httpd (redhat like distros);
 - nginx;
 - lighttpd.

Standard options available are:
<pre>
<code>
   $x_frame_options                     = 'SAMEORIGIN'
   $x_content_type_options              = 'nosniff'
   $x_xss_protection                    = '1; mode=block'
   $x_robots_tag                        = ''
   $public_key_pins                     = ''
   $strict_transport_security           = ''
   $content_security_policy             = ''
   $content_security_policy_report_only = ''
   $x_content_security_policy           = ''
   $x_webkit_csp                        = ''
</code>
</pre>
For more information about secure HTTP headers see:
* [OWASP: Secure Headers Project][1];
* This [article][2] in brazilian portuguese (pt_BR).

### 3. Usage <a id="usage"></a>
---
#### Installation <a id="installation"></a>
<pre>
<code>
$ puppet module install amenezes-http_hardening
</code>
</pre>
#### Use <a id="use"></a>
* Basic usage for apache2 (Debian like distros) and
  httpd (RedHat like distros).
  This will enable mod_headers and set standard secure http headers.
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
> **note: mod_setenv will be enabled by default, if not already.**

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
</code>
</pre>
<pre>
<code>
http_hardening::custom_apache { 'custom_config_2':
  custom_filter  => '\.(js|css)$',
  custom_headers => {
    'P3P' => 'CP=\"CAO PSA OUR\"'
  }
}
</code>
</pre>

For more information see: man [mod_headers][3]


* Custom HTTP Headers configuration on lighttpd.
<pre>
<code>
http_hardening::custom_lighttpd { 'custom_config_1':
  custom_headers => {
    'X-XSS-Protection' => '0',
  }
}
</code>
</pre>
<pre>
<code>
http_hardening::custom_lighttpd { 'custom_config_2':
  custom_filter  => '\.(js|css)$',
  custom_headers => {
    'P3P' => 'CP=\"CAO PSA OUR\"'
  }
}
</code>
</pre>

### 5. Contact <a id="contact"></a>
author: alexandre menezes  
twitter: [@ale_menezes][4]  

[1]:https://www.owasp.org/index.php?title=OWASP_Secure_Headers_Project
[2]:https://goo.gl/M9vnpk
[3]:https://goo.gl/d5B2hm
[4]:https://www.twitter.com/ale_menezes
