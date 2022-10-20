#!/bin/bash

# Simulate Default Github Action Runner Variables
GITHUB_REF=refs/heads/$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo development)
GITHUB_SHA=$(`git rev-parse HEAD 2>/dev/null` || echo 0000000000000000000000000000000000000000)

# Interpolation Variables Used to Convert src/files/preseed.template.cfg to src/files/preseed.cfg
export NEW_USER_USERNAME_PLACEHOLDER=
export NEW_USER_PASSWORD_PLACEHOLDER=
export NEW_USER_GROUPNAME_PLACEHOLDER=
export ROOT_USER_PASSWORD_PLACEHOLDER=
export GIT_HOST_PLACEHOLDER=github.com

# Packer Template Input Variables
export PKR_VAR_id_rsa=
export PKR_VAR_id_rsa_pub=
export PKR_VAR_iso_checksum=SHA256:07b94e6b1a0b0260b94c83d6bb76b26bf7a310dc78d7a9c7432809fb9bc6194a
export PKR_VAR_iso_url=http://mirrors.ocf.berkeley.edu/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso
export PKR_VAR_bridge=
export PKR_VAR_iso_storage_pool=
export PKR_VAR_node=
export PKR_VAR_password=
export PKR_VAR_storage_pool=
export PKR_VAR_storage_pool_type=
export PKR_VAR_proxmox_url=https://<IP or Hostname>:8006/api2/json
export PKR_VAR_username=
export PKR_VAR_vm_name="centos-2009-${GITHUB_REF#refs/heads/}-${GITHUB_SHA:~8}"
export PKR_VAR_ssh_password=
export PKR_VAR_ssh_username=

# Uncomment to Enable Debugging
# export PACKER_LOG=1
# export PACKER_LOG_PATH=debug.log
