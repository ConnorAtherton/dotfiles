TODO
---

- Pick a bg which will be the same as the Xresources colors
- Make rofi look pretty
- Install i3-lock
- Document how to connect to other networks on linux mint with the new setup
- Link ~/.ssh/config automatically
- Start the docker daemon on startup automatically
- Get VPN automatically connected in linux (random selection)
- Trap sigint and sigexit for spinners and terminate the script nicely.
- Instead of silencing all output, place it in an install tmp file and redirect everything there,
  to help with debugging, or just to see what happened.
- Automatically install font files
- Download docker on Mac from this known url https://download.docker.com/mac/stable/Docker.dmg

- Git global config

```
git config --global gpg.program gpg
git config --global commit.gpgsign true
```

- Agents to start when computer starts up again
    - gpg-agent --daemon
    - sshd

- Cron to do some cleanup stuff:
  -> put all files on desktop into a compressed folder with date timestamp
  -> backup using restic to external place
  -> check last time manually backing up things to 1) dropbox and 2) local hd

- Create a rust version of `fokus` to block sites in /etc/hosts

```
# IPV4
127.0.0.1 twitter.com
# IPV6
::1 twitter.com
```
