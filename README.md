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

**Re-running is safe.** The playbook is idempotent — if a run dies partway
(dropped network, a mirror timing out), just run it again. Tasks that already
completed are skipped, so the second run picks up where the first left off.

**See the real error.** Many tasks retry on failure, and by default a retrying
task only prints `FAILED - RETRYING` with no reason until its last attempt.
Add `-vvv` to see the actual error as it happens:
```
ansible-playbook /tmp/kaliConfig/config.yaml -K -vvv
```

**Resume from a specific task** instead of re-running the whole playbook. Copy
the task name from the failed output:
```
ansible-playbook /tmp/kaliConfig/config.yaml -K --start-at-task "<task name>"
```

**Check syntax without running anything**, e.g. after editing the playbook:
```
ansible-playbook /tmp/kaliConfig/config.yaml --syntax-check
```

**Preview changes** without applying them, to see what a run would do:
```
ansible-playbook /tmp/kaliConfig/config.yaml -K --check
```

**A task looks frozen but isn't.** Ansible buffers a task's output until it
finishes, so a big apt batch or a large download shows nothing for a while.
Watch progress from a second terminal:
```
tail -f /var/log/apt/term.log
```

**apt/dpkg lock errors** (`Could not get lock`, `Unable to acquire the dpkg
frontend lock`) mean another process is using the package manager — often an
automatic background update. Wait for it to finish, or find what holds the lock:
```
sudo fuser -v /var/lib/dpkg/lock-frontend
```

**"Missing sudo password" or permission errors** — the playbook needs the
become (sudo) password. Always pass `-K` and enter your password when prompted:
```
ansible-playbook /tmp/kaliConfig/config.yaml -K
```

**Newly installed CLIs aren't found** after a run. Tools land in `~/.local/bin`,
`~/go/bin`, and `~/.cargo/bin`; open a new shell (or `source ~/.zshrc`) so your
`PATH` picks them up. A full reboot is also needed for the `docker` group
membership to take effect.
