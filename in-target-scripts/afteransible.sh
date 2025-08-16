#!/bin/bash

#cleanup ansible /dev/shm fix
echo "In Target script: unmount /dev/shm"
umount /dev/shm || true
umount_status=$?
echo "In Target script: restore fstab"
cp -rf /etc/fstabbackup /etc/fstab
fstab_restore_status=$?
echo "In Target script: remove temporary /dev/shm folder"
rm -rf /dev/shm
shm_remove_status=$?
echo "In Target script: remove fstab backup"
rm -rf /etc/fstabbackup
fstab_backup_delete_status=$?


if [[ $umount_status -ne 0 || $fstab_restore_status -ne 0 || $shm_remove_status -ne 0 || $fstab_backup_delete_status -ne 0 ]]; then

    echo "errors in afteransible.sh detected. Exit codes:"
    echo "umount_status: $umount_status"
    echo "fstab_restore_status: $fstab_restore_status"
    echo "shm_remove_status: $shm_remove_status"
    echo "fstab_backup_delete_status: $fstab_backup_delete_status"
    exit 111

else
    echo "afteransible.sh completed successfully"

fi

