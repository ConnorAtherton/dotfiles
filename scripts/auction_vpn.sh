#!/bin/sh

PASSWORD="Auction123"
TOKEN=push

if [ $# -eq 1 ]; then
  TOKEN=$1
fi

printf "%s\\n%s\\n\\n\\n\\n" "$PASSWORD" "$TOKEN" \
  | openconnect --user=catherton --authgroup=AUCTION-EMPL-ANYCONNECT --passwd-on-stdin r2.auction.com
