exec { 'apt-update':
  command => '/usr/bin/apt-get update'
}

package { ['openjdk-11-jre', 'unzip']:
  require => Exec['apt-update'],
  ensure => installed,
}

exec { "deploy-app":
  command => "unzip /vagrant/springapp/springapp.zip -d /srv",
  path => "/usr/bin",
  before => Exec['run-app'],
}

exec { 'run-app':
  require => Package['openjdk-11-jre'],
  path => "/usr/bin",
  command => 'nohup java -Dspring.profiles.active=mysql -jar /srv/*.jar &',
}