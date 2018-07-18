#!/bin/sh

PASSWORD="Auction123"
TOKEN=push
if [ $# -eq 1 ]; then
  TOKEN=$1
fi

echo "$PASSWORD\n$TOKEN\n\n\n\n" | openconnect --user=catherton --authgroup=AUCTION-EMPL-ANYCONNECT --passwd-on-stdin r2.auction.com
