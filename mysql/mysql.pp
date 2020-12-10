exec { 'apt-update':
  command => '/usr/bin/apt-get update'
}

package { ['mysql-server-5.7']:
  require => Exec['apt-update'],
  ensure => installed,
}

service { "mysql":
  ensure => running,
  enable => true,
  hasstatus => true,
  hasrestart => true,
  require => Package["mysql-server-5.7"]
}

exec { 'run-script':
  require => Service["mysql"],
  path => "/usr/bin",
  unless => "mysql -u root petclinic",
  command => 'mysql < /vagrant/mysql/script/user.sql && mysql < /vagrant/mysql/script/schema.sql && mysql < /vagrant/mysql/script/data.sql'
}

file { "/etc/mysql/mysql.conf.d/mysqld.cnf":
  source => "/vagrant/mysql/mysqld.cnf",
  owner => "mysql",
  group => "mysql",
  mode => "0644",
  require => Package["mysql-server-5.7"],
  notify => Service["mysql"]
}