#!/bin/bash

# Pick a well-known locatin on disk
mkdir -p "$HOME/Videos/YouTube/.archives"
cd "$HOME/Videos/YouTube"

dl () {
  youtube-dl --download-archive .archives/"$1".txt -f         \
      bestvideo+bestaudio --dateafter 20200701 --write-sub    \
      --write-auto-sub --sub-format srt/best --sub-lang en    \
      --embed-subs -o "%(uploader)s/%(title)s.%(ext)s"        \
      --playlist-end 5 "$2"

  sleep 5
}

dl bingingwithbabish    https://www.youtube.com/user/bgfilms
dl logosbynick          https://www.youtube.com/channel/UCEQXp_fcqwPcqrzNtWJ1w9w
dl techquickie          https://www.youtube.com/user/Techquickie
dl linustechtips        https://www.youtube.com/user/LinusTechTips
dl wendoverproductions  https://www.youtube.com/channel/UC9RM-iSvTu1uPJb8X5yp3EQ
dl halfasintertesting   https://www.youtube.com/channel/UCuCkxoKLYO_EQ2GeFtbM_bw
dl sampsonboatco        https://www.youtube.com/channel/UCg-_lYeV8hBnDSay7nmphUA
dl simplelivingalaska   https://www.youtube.com/channel/UC3FHvW16m_i117IqPnb0nmA
dl mynameisandong       https://www.youtube.com/channel/UCyEA3vUnlpg0xzkECEq1rOA
dl eaterbc              https://www.youtube.com/user/eaterbc
dl dadhowdoi            https://www.youtube.com/dadhowdoi
dl caninetraining       https://www.youtube.com/channel/UCDMdcpyb3Hp3bQCIIv8HBLQ
