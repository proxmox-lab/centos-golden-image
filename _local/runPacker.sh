#!/bin/bash

# See https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set -euo pipefail

# Normalize Input Command
COMMAND=$(echo "$1" | tr '[:upper:]' '[:lower:]')

# Validate Inputs
if [ -z "$COMMAND" ] || ([ "$COMMAND" != "init" ] && [ "$COMMAND" != "fmt" ] && [ "$COMMAND" != "inspect" ] && [ "$COMMAND" != "validate" ] && [ "$COMMAND" != "build" ]); then
  echo "You must pass one of the following arguments to this script: init, fmt, inspect, validate, build."
  exit 1
fi

# Bootstrap Environment
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ -f "$DIR/bootstrapEnvironment.sh" ]; then
  . $DIR/bootstrapEnvironment.sh
fi

cd $DIR/../src

###############################################################################
# Populate Environment-Specific Values in Boot Configuration File
###############################################################################
cat $DIR/../src/files/http/preseed.template.cfg > $DIR/../src/files/http/preseed_pve.cfg
cat $DIR/../src/files/http/post_pve.cfg >> $DIR/../src/files/http/preseed_pve.cfg
if [[ $(uname -s) == 'Linux' ]]; then
  sed -i "s/GIT_HOST_PLACEHOLDER/$GIT_HOST_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
  sed -i "s/NEW_USER_USERNAME_PLACEHOLDER/$NEW_USER_USERNAME_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
  sed -i "s/NEW_USER_PASSWORD_PLACEHOLDER/$NEW_USER_PASSWORD_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
  sed -i "s/NEW_USER_GROUPNAME_PLACEHOLDER/$NEW_USER_GROUPNAME_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
  sed -i "s/ROOT_USER_PASSWORD_PLACEHOLDER/$ROOT_USER_PASSWORD_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
else
  # Mac :-(  Still better than Powershell or MSDOS Command Prompt
  sed -i '' "s/GIT_HOST_PLACEHOLDER/$GIT_HOST_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
  sed -i '' "s/NEW_USER_USERNAME_PLACEHOLDER/$NEW_USER_USERNAME_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
  sed -i '' "s/NEW_USER_PASSWORD_PLACEHOLDER/$NEW_USER_PASSWORD_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
  sed -i '' "s/NEW_USER_GROUPNAME_PLACEHOLDER/$NEW_USER_GROUPNAME_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
  sed -i '' "s/ROOT_USER_PASSWORD_PLACEHOLDER/$ROOT_USER_PASSWORD_PLACEHOLDER/g" $DIR/../src/files/http/preseed_pve.cfg
fi

# Run Packer Command
packer $@ $DIR/../src/
