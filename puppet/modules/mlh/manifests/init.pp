class mlh {

  $mlhpackages = [ "httpd", "mod_ssl", "php", "php-cli", "php-common", 
  "php-devel", "php-mcrypt", "php-intl", "php-mbstring", "php-mysql", "php-pdo", "php-soap", 
  "php-pecl-memcache", "php-gd", "php-pecl-xdebug", "php-xml", "poppler", "poppler-utils", "poppler-data", ]
  
  $mlhdirectories = [ "/var/www/html", "/var/www/html/magento"]

  package { $mlhpackages:
    ensure => "installed",
  }
  
   $phpdevpackages = [ "libxml2-devel", "libXpm-devel", "libcurl-devel", "libjpeg-devel", "libvpx-devel", "libpng-devel"]
  
 
  
  package { $phpdevpackages:
    ensure => "installed",
  }
  
  
  


  service { "httpd" :
    ensure => running,
    enable => true,
    require => Package["httpd"],
  }
  
  file { $mlhdirectories:
    ensure => directory,
    owner => apache,
    group => apache,
    mode => 755,
    require => Package["httpd"],
  }

  file { "/etc/httpd/conf/httpd.conf":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/mlh/etc/httpd/conf/httpd.conf",
    require => Package["httpd"],
    notify => Service["httpd"],
  }

  file { "/etc/httpd/conf.d/mlh.conf":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/mlh/etc/httpd/conf.d/mlh.conf",
    require => Package["httpd"],
    notify => Service["httpd"],
  }
  
  file { "/etc/httpd/conf.d/ssl_mlh.conf":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/mlh/etc/httpd/conf.d/ssl_mlh.conf",
    require => Package["mod_ssl"],
    notify => Service["httpd"],
  }

  file { "/etc/php.ini":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/mlh/etc/php.ini",
    require => Package["php"],
    notify => Service["httpd"],
  }

  file { "/etc/php.d/xdebug.ini":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/mlh/etc/php.d/xdebug.ini",
    require => Package["php-pecl-xdebug"],
    notify => Service["httpd"],
  }


  package { "mysql-server":
    ensure  => present,
  }

  package { "mysql":
    ensure  => present,
  }

  service { "mysqld":
    ensure => running, 
    require => Package["mysql-server"]
  }

}



