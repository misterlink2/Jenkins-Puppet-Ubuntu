# Jenkins-Puppet-Ubuntu
Follow these instructions to install Jenkins on port 8000 on Ubuntu 22.04 with Puppet.

### 1. Download the Ubuntu 22.04 (Jammy Jellyfish) Puppet 8 release package
Downloads Puppet config file.

```wget https://apt.puppetlabs.com/puppet8-release-jammy.deb```

### 2. Install the repository configuration
dpkg adds Puppet's repository to the Trusted Sources list and installs security keys.

```sudo dpkg -i puppet8-release-jammy.deb```

### 3. Update package lists
Refreshes the OS knowledge of available packages.

```sudo apt update```

### 4. Install puppet-agent
Downloads the Puppet Agent.

```sudo apt install -y puppet-agent```

### 5. Path Configuration
Updates current terminal to include Puppet in the PATH, so the puppet command can be ran.

```source /etc/profile.d/puppet-agent.sh```

### 6 Install puppet-jenkins
Downloads the Jenkins module to handle Java and Jenkins configuration.

```puppet module install puppet-jenkins```

### 7. Pull manifest from Github
Pulls manifest from Github.

```git clone https://github.com/misterlink2/Jenkins-Puppet-Ubuntu.git```

### 8. Apply manifest
Puppet modifies the system to match what is in the manifest.

```puppet apply Jenkins-Puppet-Ubuntu/jenkins.pp```

### 9. Use Jenkins
If running this on your local device, visit localhost:8000 in your browser to view the Jenkins UI, else visit your server's IP address.

## Debug commands
Run these to troubleshoot issues.

#### Remove IP from known_hosts file
Needs to be ran if servers created and destroyed are using the same IP.

```ssh-keygen -R 89.167.71.172```

#### Update the module to the latest version
Older puppet modules can run into issues interacting with Jenkins.

```puppet module upgrade puppet-jenkins --force```

#### Verify the modules versions
puppet-jenkins should be 6.x.x or higher.

```puppet module list```

#### Download Jenkins key
The OS uses this key to verify that the Jenkins software isn't tampered with. The previous key is being phased out.

```curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null```

#### Check the status of the Jenkins service
Provide high level summary of the Jenkins service.

```systemctl status jenkins```

Shows how Jenkins is being launched.

```systemctl cat jenkins```

Show the Env vars for the Jenkins service.

```systemctl show jenkins --property=Environment```

#### View Jenkins system info
Use this link to view Jenkins system info, including the port Jenkins is listening on.

```http://<localhost or your server ip>:8000/systemInfo```

#### View Puppet overrides
View the Puppet overrides values

```cat /etc/systemd/system/jenkins.service.d/puppet-overrides.conf```
