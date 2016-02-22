# http_hardening
Puppet module to enable and manage secure http headers.

<h4>Usage:</h4>
<h5>Installation</h5>
<pre>
<code>
$ sudo puppet module install amenezes-http_hardening
</code>
</pre>
<h5>Use</h5>
* Basic usage for apache2 (Debian like distros) and httpd (RedHat like distros). This will enable mod_headers and set some secure http headers.
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

* Basic usage on nginx. This feature it's in beta stage currently.
<pre>
<code>
class { 'http_hardening': 
nginx => true,
}
</code>
</pre>

* Custom configuration on apache2 (Debian like distros) or httpd (RedHat like distros).
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

* Custom configuration on nginx. This feature it's in beta stage currently.
<pre>
<code>
class { 'http_hardening': 
nginx => true,
x_frame_options  => 'SAMEORIGIN',
x_xss_protection => '1; mode=block',
}
</code>
</pre>

<h4>Contact:</h4>
author: alexandre menezes</br>
twitter: <a href="https://www.twitter.com/ale_menezes">@ale_menezes</a>
