#!/bin/bash

# 1. Add Puppet 8 Repository
wget https://apt.puppetlabs.com/puppet8-release-jammy.deb
sudo dpkg -i puppet8-release-jammy.deb
sudo apt update

# 2. Install Puppet Agent
sudo apt install -y puppet-agent

# 3. Load Puppet into the current shell PATH
source /etc/profile.d/puppet-agent.sh

# 5. Install the Jenkins Puppet Module
/opt/puppetlabs/bin/puppet module install puppet-jenkins

# 6. Clone the Repo and Apply the Manifest
git clone https://github.com/misterlink2/Jenkins-Puppet-Ubuntu.git
/opt/puppetlabs/bin/puppet apply Jenkins-Puppet-Ubuntu/jenkins.pp