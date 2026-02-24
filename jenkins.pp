package { 'openjdk-21-jdk':
  ensure => installed,
}

include apt

apt::source { 'jenkins':
  location => 'https://pkg.jenkins.io/debian-stable',
  repos    => 'binary/',
  release  => '',
  key      => {
    'id'     => '5E386EADB55F01504CAE8BCF7198F4B714ABFC68',
    'source' => 'https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key',
  },
}

class { 'jenkins':
  install_java => false,
  repo         => false,
  config_hash  => {
    'JENKINS_PORT' => { 'value' => '8000' },
  },
  require      => [Package['openjdk-21-jdk'], Apt::Source['jenkins']],
}

Apt::Source['jenkins'] ~> Class['apt::update'] -> Class['jenkins']