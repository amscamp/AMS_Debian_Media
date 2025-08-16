#!/bin/bash

echo "In Target script: run ansible pull"
/bin/ansible-pull -vvv -d /ansibleconfig -i /ansibleconfig/inventory -U https://github.com/amscamp/AMS_Debian_Media_Ansible -C $1
ansible_pull_status=$?


if [[ $ansible_pull_status -ne 0 ]]; then

    echo "errors in runansible.sh detected. Exit codes:"
    echo "ansible_pull_status: $ansible_pull_status"
    exit 111

else
    echo "runansible.sh completed successfully"
fi

