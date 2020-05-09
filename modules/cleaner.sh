#!/bin/bash

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
#
# @distro mac
function _mac_cleaner::run () {
 # empty the trash on all mounted volumes and the main hdd
 sudo rm -rfv /Volumes/*/.Trashes
 sudo rm -rfv $HOME/.Trash
 sudo rm -rfv /private/var/log/asl/*.asl
}

function _linux_cleaner::run () {
 empty the trash on all mounted volumes and the main hdd

 sudo rm -rfv /Volumes/*/.Trashes
 sudo rm -rfv $HOME/.Trash
 sudo rm -rfv /private/var/log/asl/*.asl
}

function cleaner::run () {
  # TODO: Create a conditional eval function like this for functions to work on either
  # linux or mac at the same time
  #
  # eval "_${current_distro}_cleaner::run"
  distro_function "cleaner::run"
}
