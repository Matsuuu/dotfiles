On Arch Linux, the following works really great (should work on all systemd-based distros):

Create a systemd user service, by putting the following to ~/.config/systemd/user/ssh-agent.service:

```
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
```

Setup shell to have an environment variable for the socket (.bash_profile, .zshrc, ...):

```
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
```

Enable the service, so it'll be started automatically on login, and start it:

```
systemctl --user enable ssh-agent
systemctl --user start ssh-agent
```
Add the following configuration setting to your local ssh config file ~/.ssh/config (this works since SSH 7.2):

```
AddKeysToAgent  yes
```

This will instruct the ssh client to always add the key to a running agent, so there's no need to ssh-add it beforehand.
