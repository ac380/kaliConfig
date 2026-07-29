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

Run verbosely — a task with `retries` prints its error only on the final attempt,
so `-vv` is the only way to see why an attempt failed  
```
ansible-playbook /tmp/kaliConfig/config.yaml -K -vv
```

Follow apt from a second terminal — Ansible buffers a task's output until the
task ends, so a large package batch looks frozen while it is working  
```
tail -f /var/log/apt/term.log
```

Find what holds the apt lock, when a task fails with `Unable to acquire the dpkg
frontend lock`  
```
sudo fuser -v /var/lib/dpkg/lock-frontend
```

Resume after fixing something, instead of re-running the whole playbook  
```
ansible-playbook /tmp/kaliConfig/config.yaml -K --start-at-task "Install all required apps"
```
