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
If running this on your local device, visit ```localhost:8000``` in your browser to view the Jenkins UI, else visit your server's IP address.

## Debug commands
Run these to troubleshoot issues.

| Command | Description |
|---------|-------------|
| `ssh-keygen -R <IP>` | Remove IP from known_hosts file. Needs to be ran if servers created and destroyed are using the same IP. |
| `puppet module upgrade puppet-jenkins --force` | Update the puppet-jenkins module to the latest version. Older puppet modules can run into issues interacting with Jenkins. |
| `puppet module list` | Verify the module versions. puppet-jenkins should be 6.x.x or higher. |
| `curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \| tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null` | Download Jenkins repository signing key. The OS uses this key to verify that the Jenkins software isn't tampered with. The previous key has expired out. More info [here](https://www.jenkins.io/blog/2025/12/23/repository-signing-keys-changing/) |
| `systemctl status jenkins` | Check the status of the Jenkins service. Provides high level summary of the Jenkins service. |
| `systemctl cat jenkins` | Shows how Jenkins is being launched. |
| `systemctl show jenkins --property=Environment` | Show the environment variables for the Jenkins service. |
| `sudo tail -f /var/log/cloud-init-output.log` | View the cloud init script output. |
| `http://<localhost or your server ip>:8000/systemInfo` | View Jenkins system info, including the port Jenkins is listening on. |
| `cat /etc/systemd/system/jenkins.service.d/puppet-overrides.conf` | View the Puppet overrides values. |
