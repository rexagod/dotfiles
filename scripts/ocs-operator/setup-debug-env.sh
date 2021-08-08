# MAINTAINER: @rexagod

set -evxu

# Variables {{{

K="kubectl"
FILENAME="/tmp/CSVMeta.yaml"
US="quay.io\/rexagod\/ocs-operator:debug"
THEM="quay.io\/ocs-dev\/ocs-operator:latest"
COMMAND="/script.sh"
ARGS="\\(-\\s\\)args:\\n\\(.*\\n\\)\\{2\\}\\(\\s*\\)\\(command:\\n\\).*ocs-operator"
NO_ARGS="\\1\\4\\3- \\${COMMAND}"
VERSION="v4.9.0"
# }}}

# Get CSV metadata {{{

"${K}" get csv "ocs-operator.${VERSION}" -n openshift-storage -o yaml > "${FILENAME}"
# }}}

vim_chore() {
  vim --clean -c "${1}" -c "wq" "${FILENAME}"
}

# Inject debugger image {{{

vim_chore "%s/${THEM}/${US}/g" 
# }}}

# Chores to invoke script {{{

vim_chore "%s/${ARGS}/${NO_ARGS}"
# }}}

# Apply custom CSV {{{

"${K}" apply -f "${FILENAME}"
rm "${FILENAME}"
# }}}
