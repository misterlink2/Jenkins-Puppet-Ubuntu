#!/bin/bash

# Add Puppet 8 Repository
wget https://apt.puppetlabs.com/puppet8-release-jammy.deb
sudo dpkg -i puppet8-release-jammy.deb
sudo apt update

# Install Puppet Agent
sudo apt install -y git puppet-agent

# Load Puppet into the current shell PATH
source /etc/profile.d/puppet-agent.sh

# Install the Jenkins Puppet Module
sudo /opt/puppetlabs/bin/puppet module install puppet-jenkins

# Clone the Repo and Apply the Manifest
git clone https://github.com/misterlink2/Jenkins-Puppet-Ubuntu.git
sudo /opt/puppetlabs/bin/puppet apply Jenkins-Puppet-Ubuntu/jenkins.pp