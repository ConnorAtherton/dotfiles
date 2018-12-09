#!/bin/bash

# If this grows more hair, I will start using something like ansible...
ufw enable
ufw limit ssh
ufw allow http
ufw allow https
# Git port
ufw allow 9418
ufw status
