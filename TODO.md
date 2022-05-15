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

- Create a script to do local pull reviews in local editor, something like this
    https://github.com/sirupsen/dotfiles/blob/master/home/.bin/review

- Custom note taking system that uses a local sqllite db for storage
    https://github.com/sirupsen/dotfiles/blob/master/home/.bin/fts-search.rb

- [easy] Configure ALE correctly with js files for work.

- Check out the `bin/prose_*` scripts for proof reading. Make into a single tool for scanning.

- Upgrade vim to try out nvim:
  https://github.com/SpaceVim/SpaceVim/tree/master/bundle
  https://github.com/neovim/nvim-lspconfig/tree/507f8a570ac2b8b8dabdd0f62da3b3194bf822f8
  https://github.com/lukas-reineke/indent-blankline.nvim/tree/17a83ea765831cb0cc64f768b8c3f43479b90bbe
  https://github.com/SpaceVim/SpaceVim/blob/master/bundle/tagbar-proto.vim/ftplugin/proto.vim
  https://github.com/SpaceVim/SpaceVim/tree/master/bundle/vim-bookmarks
  https://github.com/mhinz/vim-startify

