exec { 'install-java-17':
  command => '/usr/bin/apt-get install -y openjdk-17-jdk',
  unless  => '/usr/bin/dpkg -l openjdk-17-jdk | grep -q "^ii"',
}

exec { 'add-jenkins-key':
  command => '/usr/bin/curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key | /usr/bin/tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null',
  creates => '/usr/share/keyrings/jenkins-keyring.asc',
  require => Exec['install-java-17'],
}

apt::source { 'jenkins':
  location => 'https://pkg.jenkins.io/debian-stable',
  repos    => 'binary/',
  release  => '',
  key      => {
    'id'     => '5E386EADB55F01504CAE8BCF7198F4B714ABFC68',
    'source' => 'https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key',
  },
  notify   => Exec['apt-update-jenkins'],
}

exec { 'apt-update-jenkins':
  command     => '/usr/bin/apt-get update',
  refreshonly => true,
}

class { 'jenkins':
  port         => 8000,
  install_java => false,
  repo         => false,
  config_hash  => {
    'JENKINS_PORT' => { 'value' => '8000' },
  },
  require      => Exec['apt-update-jenkins'],
}

