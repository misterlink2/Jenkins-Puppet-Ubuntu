# Jenkins-Puppet-Ubuntu
Follow these instructions to install Jenkins on port 8000 on Ubuntu with Puppet

### 1. Download the Ubuntu 22.04 (Jammy Jellyfish) Puppet release package
```wget https://apt.puppetlabs.com/puppet8-release-jammy.deb```

### 2. Install the repository configuration

```sudo dpkg -i puppet8-release-jammy.deb```

### 3. Update package lists
```sudo apt update```

### 4. Install the Puppet Agent
```sudo apt install -y puppet-agent```

### 5. Path Configuration:
```source /etc/profile.d/puppet-agent.sh```

### 6 Install puppet-jenkins
```puppet module install puppet-jenkins```

### 7. Pull manifest from Github
```git clone https://github.com/misterlink2/Jenkins-Puppet-Ubuntu.git```

### 8. Apply manifest
```cd Jenkins-Puppet-Ubuntu && puppet apply jenkins.pp```

## Debug commands:
Run these to troubleshoot issues

#### Update the module to the latest version
Older puppet modules can run into issues interacting with Jenkins

```puppet module upgrade puppet-jenkins --force```

#### Verify the modules versions
puppet-jenkins should be 6.x.x or higher

```puppet module list```

#### Download Jenkins key
Jenkins updated their GPG keys, download a new one

```curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null```

#### Check the status of the Jenkins service
Check the status of the Jenkins service

```systemctl status jenkins```

List the configuration of the Jenkins service

```systemctl cat jenkins```

Show the Env vars for the Jenkins service

```systemctl show jenkins --property=Environment```

#### View Jenkins system info
Use this link to view Jenkins system info, including the port Jenkins is listening on

```http://<your-server-ip>:8000/systemInfo```

#### View Puppet overrides
View the Puppet overrides values

```cat /etc/systemd/system/jenkins.service.d/puppet-overrides.conf```
