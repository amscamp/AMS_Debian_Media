#!/bin/bash

#ansible prereqs
echo "In Target script: install ansible role community general"
ansible-galaxy collection install community.general
galaxy_community_status=$?


#ansible /dev/shm fix
echo "In Target script: create temporary /dev/shm folder"
mkdir /dev/shm 
shm_create_status=$?

echo "In Target script: set permissions on temporary /dev/shm folder"
chmod 777 /dev/shm
shm_chmod_status=$?

echo "In Target script: backup fstab"
cp /etc/fstab /etc/fstabbackup
fstab_backup_status=$?

echo "In Target script: add /dev/shm to fstab"
echo 'none /dev/shm tmpfs rw,nosuid,nodev,noexec 0 0' >> /etc/fstab
shm_fstab_status=$?

echo "In Target script: mount /dev/shm"
mount /dev/shm
shm_mount_status=$?


#ansibleconfig folder
echo "In Target script: create /ansibleconfig folder"
mkdir /ansibleconfig
ansibleconfig_create_status=$?

if [[ $galaxy_community_status -ne 0 || $shm_create_status -ne 0 || $shm_chmod_status -ne 0 || $fstab_backup_status -ne 0 || $shm_fstab_status -ne 0 || $shm_mount_status -ne 0 || $ansibleconfig_create_status -ne 0 ]]; then

    echo "errors in prepareansible.sh detected. Exit codes:"
    echo "galaxy_community_status: $galaxy_community_status"
    echo "shm_create_status: $shm_create_status"
    echo "shm_chmod_status: $shm_chmod_status"
    echo "fstab_backup_status: $fstab_backup_status"
    echo "shm_fstab_status: $shm_fstab_status"
    echo "shm_mount_status: $shm_mount_status"
    echo "ansibleconfig_create_status: $ansibleconfig_create_status"
    exit 111

else
    echo "prepareansible.sh completed successfully"

fi

