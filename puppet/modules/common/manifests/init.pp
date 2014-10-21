class common {
  
  $commonpackages = ["wget", "ntp", "mailx", "curl"]
  
  package { $commonpackages:
    ensure => "installed",
  }
  
  file { "auction.repo":
    path => "/etc/yum.repos.d/auction.repo",
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/common/etc/yum.repos.d/auction.repo"
  }
  
  file { "/etc/hosts":
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/common/etc/hosts",
  }
  
  service { "ntpd" :
    ensure => running,
    enable => true,
    require => Package["ntp"],
  }
    
}