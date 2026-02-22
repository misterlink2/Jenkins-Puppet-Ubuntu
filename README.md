# Jenkins-Puppet-Ubuntu
Follow these instructions to install Jenkins on port 8000 on Ubuntu 22.04 with Puppet.

## Requirements
- Ubuntu 22.04 (Jammy Jellyfish)
- Ubuntu user with Sudo permissions or root
- These instructions are best viewed here: [https://github.com/misterlink2/Jenkins-Puppet-Ubuntu/blob/main/README.md](https://github.com/misterlink2/Jenkins-Puppet-Ubuntu/blob/main/README.md)

## Method 1, Configure and run Puppet

### 1. Download the Ubuntu 22.04 Puppet 8 release package
Downloads Puppet config file.

```wget https://apt.puppetlabs.com/puppet8-release-jammy.deb```

### 2. Install the repository configuration
dpkg adds Puppet's repository to the Trusted Sources list and installs security keys.

```sudo dpkg -i puppet8-release-jammy.deb```

### 3. Update package lists
Refreshes the OS knowledge of available packages.

```sudo apt update```

### 4. Install git and puppet-agent
Downloads git and the Puppet Agent.

```sudo apt install -y git puppet-agent```

### 5. Install puppet-jenkins
Downloads the Jenkins module to handle Java and Jenkins configuration.

```sudo /opt/puppetlabs/bin/puppet module install puppet-jenkins```

### 6. Pull manifest from Github
Pulls manifest from Github.

```git clone https://github.com/misterlink2/Jenkins-Puppet-Ubuntu.git```

### 7. Apply manifest
Puppet modifies the system to match what is in the manifest.

```sudo /opt/puppetlabs/bin/puppet apply Jenkins-Puppet-Ubuntu/jenkins.pp```

### 8. Use Jenkins
If running this on your local device, visit ```localhost:8000``` in your browser to view the Jenkins UI, else visit ```<your-server-IP>:8000```.

## Method 2, Run bash script
This is not an idempotent script, but shows that the terminal and Puppet commands can be ran in a script, and subsequent puppet commands are still idempotent.

Pull down the script, manifest, etc.

```git clone https://github.com/misterlink2/Jenkins-Puppet-Ubuntu.git```

Give the script execute permissions

```chmod +x ./Jenkins-Puppet-Ubuntu/hetzner-cloud/install_jenkins.sh```

Run the script

```./Jenkins-Puppet-Ubuntu/hetzner-cloud/install_jenkins.sh```

## Method 3, cloud-init script
This just takes the earlier mentioned ```install_jenkins.sh``` script and runs it automatically when the server is spun up. This is specified in ```hetzner-cloud/main.tf``` (line 98), and needs to be uncommented to be enabled. This uses Terraform to create a cloud server on Hetzner cloud, where a Hetzner account and API token are needed. This script is still not idempotent, but shows that Jenkins can be set up upon server creation without any commands being ran. Subsequent Puppet commands are still idempotent.

## Debug commands
Run these to troubleshoot issues.

| Command | Description |
|---------|-------------|
| `ssh-keygen -R <IP>` | Remove IP from known_hosts file. Needs to be ran if servers created and destroyed are using the same IP. |
| `puppet module upgrade puppet-jenkins --force` | Update the puppet-jenkins module to the latest version. Older puppet modules can run into issues interacting with Jenkins. |
| `puppet module list` | Verify the module versions. puppet-jenkins should be 6.x.x or higher. |
| `curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \| tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null` | Download Jenkins repository signing key. The OS uses this key to verify that the Jenkins software isn't tampered with. The previous key has expired out. More info [here](https://www.jenkins.io/blog/2025/12/23/repository-signing-keys-changing/) |
|`source /etc/profile.d/puppet-agent.sh`| Updates current terminal to include Puppet in the PATH, does not include Sudo PATH|
| `systemctl status jenkins` | Check the status of the Jenkins service. Provides high level summary of the Jenkins service. |
| `systemctl cat jenkins` | Shows how Jenkins is being launched. |
| `systemctl show jenkins --property=Environment` | Show the environment variables for the Jenkins service. |
| `sudo tail -f /var/log/cloud-init-output.log` | View the cloud init script output. |
| `http://<localhost or your server ip>:8000/systemInfo` | View Jenkins system info, including the port Jenkins is listening on. |
| `cat /etc/systemd/system/jenkins.service.d/puppet-overrides.conf` | View the Puppet overrides values. |
