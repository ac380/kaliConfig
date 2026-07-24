# kaliConfig
Prepares a brand new Kali installation with all the tools and customizations needed for pentesting.

## Shortcuts
Install Ansible  
```
sudo apt update && sudo apt install ansible -y
```

Clone the repository  
```
git clone https://github.com/ac380/kaliConfig.git /tmp/kaliConfig
```

Install the required Ansible collections  
```
ansible-galaxy collection install -r /tmp/kaliConfig/requirements.yml
```

Run the config

```
ansible-playbook /tmp/kaliConfig/config.yaml -K
```
