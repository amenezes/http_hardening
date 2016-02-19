# http_hardening
Puppet module to enable and manage http security headers.

<h4>Usage:</h4>
<h5>Installation</h5>
<pre>
<code>
$ sudo puppet module install amenezes-http_hardening
</code>
</pre>
<h5>Use</h5>
* Basic usage on apache2 (httpd). This will enable mod_headers and set some secure http headers.
<pre>
<code>
class { 'http_hardening': }
include http_hardening::apache2
</code>
</pre>

* Basic usage on nginx. #TODO. This feature it's not available currently.
<pre>
<code>
class { 'http_hardening': }
include http_hardening::nginx
</code>
</pre>

* Custom configuration on apache2 (htpd).
<pre>
<code>
class { 'http_hardening': }
include http_hardening::apache2 { 'apache2':
x_frame_options  => 'SAMEORIGIN',
x_xss_protection => '1; mode=block',
}
</code>
</pre>

* Custom configuration on nginx. #TODO This feature it's not available currently.
<pre>
<code>
class { 'http_hardening': }
include http_hardening::nginx { 'nginx':
x_frame_options  => 'SAMEORIGIN',
x_xss_protection => '1; mode=block',
}
</code>
</pre>

<h4>Contact:</h4>
author: alexandre menezes</br>
twitter: <a href="https://www.twitter.com/ale_menezes">@ale_menezes</a>
