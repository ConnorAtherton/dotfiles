#!/bin/bash

mkdir -p /mnt/{persistent_git_storage,persistent_docker_registry_storage}

# I think this is the git one..
mount -o discard,defaults,noatime /dev/disk/by-id/scsi-0DO_Volume_sdb /mnt/persistent_git_storage
# which leaves this as the docker registry one
mount -o discard,defaults,noatime /dev/disk/by-id/scsi-0DO_Volume_sdc /mnt/persistent_docker_registry_storage

echo '/dev/disk/by-id/scsi-0DO_Volume_sdb /mnt/persistent_git_storage ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab
echo '/dev/disk/by-id/scsi-0DO_Volume_sdc /mnt/persistent_docker_registry_storage ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab

exit 0
