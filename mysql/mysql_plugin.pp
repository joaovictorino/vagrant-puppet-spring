class { '::mysql::server':
  restart                 => true,
  override_options        => {
    mysqld => {
      'bind_address' => '0.0.0.0',
    }
  }
}

mysql::db { 'petclinic':
  user     => 'petclinic',
  password => 'petclinic',
  host     => '%',
  grant    => ['ALL PRIVILEGES'],
  require => Service['mysqld'],
  sql     => [ '/vagrant/mysql/script/schema.sql',
               '/vagrant/mysql/script/data.sql' ]
}