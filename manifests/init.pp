class localrepo {
  package {'createrepo':
    ensure => present,
  }
}

define localrepo::repo (
  $simple_apache_setup = true,
  $webroot = '/srv/www',
  $scriptdir = '/srv/scripts',
  $versions = [6],
  $archs = ['x86_64']
)
{
  file {"$webroot/$name":
    ensure => directory,
  }

  $fullpath = "$webroot/$name/$version/$arch"
  
  file {"$scriptdir/make-$name.sh":
    owner   => root,
    group   => root,
    mode    => 700,
    content => template('localrepo/make-repo.sh.erb'),
    require => Package ['createrepo'],
  }

  if $simple_apache_setup {
    file {"/etc/httpd/conf.d/$name.conf":
      owner   => root,
      group   => root,
      mode    => 644,
      content => template('localrepo/repo.conf.erb'),
      notify  => Service ['httpd'],
    }
  }

}
