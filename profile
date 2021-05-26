#!/usr/local/bin/bash

workdir=$(cd $(dirname "$0"); pwd)
echo "$workdir"

# shellcheck source=/dev/null
source "${workdir}/alias.sh"

# shellcheck source=/dev/null
source "${workdir}/env.sh"

# shellcheck source=/dev/null
source "${workdir}/export.sh"

# shellcheck source=/dev/null
source "${workdir}/function.sh"