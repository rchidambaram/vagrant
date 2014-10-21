class adc {

  $adcpackages = [ "httpd", "mod_ssl", "php", "php-mysql", "php-soap", "php-pecl-memcache", "php-gd", "php-pecl-xdebug", "php-xml", "poppler", "poppler-utils", "poppler-data"]

  package { $adcpackages:
    ensure => "installed",
  }

  service { "httpd" :
    ensure => running,
    enable => true,
    require => Package["httpd"],
  }

  file { "/etc/httpd/conf/httpd.conf":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/adc/etc/httpd/conf/httpd.conf",
    require => Package["httpd"],
    notify => Service["httpd"],
  }
  
  file { "/etc/httpd/conf.d/adc.conf":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/adc/etc/httpd/conf.d/adc.conf",
    require => Package["httpd"],
    notify => Service["httpd"],
  }
  
  file { "/etc/httpd/conf.d/ssl_adc.conf":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/adc/etc/httpd/conf.d/ssl_adc.conf",
    require => Package["mod_ssl"],
    notify => Service["httpd"],
  }

  file { "/etc/php.ini":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/adc/etc/php.ini",
    require => Package["php"],
    notify => Service["httpd"],
  }

  file { "/etc/php.d/xdebug.ini":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/adc/etc/php.d/xdebug.ini",
    require => Package["php-pecl-xdebug"],
    notify => Service["httpd"],
  }

  file { "/var/www/html/public_html":
    ensure => directory,
    owner => root,
    group => root,
    mode => 755,
    require => Package["httpd"],
  }

}
