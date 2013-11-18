puppet-localrepo
================

Simple puppet module for setting up a RPM package repository.

Example usage:

````
  class {'localrepo': }
  localrepo::repo {'asteroids-repo':,
    versions => [6],
    archs    => ['x86_64', 'SRPMS']
  }
````

which will create a script under /srv/scripts to create and update the
repo as required.
