#!/bin/sh

# Install Ansible if not already installed
if ansible --version >/dev/null 2>&1; then
    echo "Installing Emhome with Ansible ..."
else
    echo "Installing Ansible"
    sudo apk add --no-interactive --no-cache ansible
    if [ $? -ne 0 ]; then
        echo "Failed to install Ansible. Exiting."
        exit 1
    fi
fi

# Run the playbook
doas ansible-playbook -i inventory playbook.yml "$@"