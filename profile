#!/usr/local/bin/bash

workdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "$workdir"

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
