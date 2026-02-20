# Jenkins-Puppet-Ubuntu
Install Jenkins on port 8000 on a fresh install of Ubuntu with Puppet

# 1. Download the Jammy release package from the correct URL
wget https://apt.puppetlabs.com/puppet8-release-jammy.deb

# 2. Install the repository configuration
sudo dpkg -i puppet8-release-jammy.deb

# 3. Update your package lists
sudo apt update

# 4. Install the Puppet Agent
sudo apt install -y puppet-agent

# 5. Path Configuration:
source /etc/profile.d/puppet-agent.sh

# 6
puppet module install puppet-jenkins

 #7.
Create and apply manifest
#pull from git?
systemctl status jenkins

Debug commands:

# 1. Update the module to the latest version
puppet module upgrade puppet-jenkins --force

# 2. Verify the version (it should be 6.x.x or higher)
puppet module list

Download jenkins key:
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

systemctl show jenkins --property=Environment

http://<your-server-ip>:8000/systemInfo

 systemctl cat jenkins

cat /etc/systemd/system/jenkins.service.d/puppet-overrides.conf
