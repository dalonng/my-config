#!/usr/local/bin/bash

workdir=$(
  cd "$(dirname "$0")"
  pwd
) || exit 1
#echo "$workdir"

# shellcheck source=/dev/null
source "${workdir}/alias.sh"

# shellcheck source=/dev/null
source "${workdir}/env.sh"

# shellcheck source=/dev/null
source "${workdir}/export.sh"

# shellcheck source=/dev/null
source "${workdir}/function.sh"

RESOLUTION=$(system_profiler SPDisplaysDataType | grep "Resolution")
if [[ "$RESOLUTION" == *"3072 x 1920"* ]]; then
  # shellcheck source=/dev/null
  source "${workdir}/custom_mbp_16.sh"
    echo "custom_mbp_16.sh loaded successfully"
fi

#if [[ $(uname -s) == "Darwin" ]]; then
#  echo "This is Mac"
#fi
