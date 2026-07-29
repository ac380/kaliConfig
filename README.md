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

## Troubleshooting

`FAILED - RETRYING: ... (5 retries left).` with no reason shown is expected from
Ansible's default output: on a task with `retries`, the module's error message is
only printed on the **final** attempt. Re-run with `-vv` to see the actual
failure on every attempt:

```
ansible-playbook /tmp/kaliConfig/config.yaml -K -vv
```
