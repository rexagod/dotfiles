# fail fast on error
set -e

# repository directory
ES_DIR="${GOPATH}/src/github.com/kubernetes-csi/external-snapshotter"
# target file
YAML="${ES_DIR}/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml"

# apply all resources the first time
if [[ "$1" == "init" ]]; then
  kubectl apply -f "${ES_DIR}/client/config/crd"
  kubectl apply -f "${ES_DIR}/deploy/kubernetes/snapshot-controller"
  kubectl apply -f "${ES_DIR}/deploy/kubernetes/csi-snapshotter"
# deploy new snapshot-controller version and update image
else
  # remove OCP resources (we'll replace them with testing ones)
  kubectl delete deploy csi-snapshot-controller-operator -n openshift-cluster-storage-operator
  kubectl delete deploy csi-snapshot-controller -n openshift-cluster-storage-operator
  # artifact file to store US_OLD for next time
  ARTIFACT="/home/rexagod/.local/external-snapshotter.artifact.bash"
  if [[ -f "$ARTIFACT" ]]; then
    tput setaf 2; echo "::artifact found::"; tput sgr0
    cat "$ARTIFACT"
    source "$ARTIFACT"
  else
    touch "$ARTIFACT"
  fi
  # newer image URI
  US="quay.io/rexagod/external-snapshotter:latest-${RANDOM}"
  # notify about older image
  if [[ -n "$US_" ]]; then
    tput setaf 2; echo "::Found older image~${US_}::"; tput sgr0
  fi
  # default OCP snapshot-controller image
  THEY="k8s.gcr.io/sig-storage/snapshot-controller:v4.1.1"
  # replace default image with newer one (happens if changes were made manually)
  sed -i "s|${THEY}|${US}|" "${YAML}"
  # image that'll be replaced
  THEY="${US_:-${THEY}}"
  tput setaf 3; echo "::Image to be replaced~${THEY}::"; tput sgr0
  cp ./Dockerfile "$ES_DIR"
  # change workdir
  cd "$ES_DIR"
  # replace older images w/ newer ones
  sed -i "s|${THEY}|${US}|" "${YAML}"
  sed -i "s|IfNotPresent|Always|" "${YAML}"
  # tag and push
  docker build -t "$US" .
  docker push "$US"
  # update cluster with newer image
  kubectl apply -f "${ES_DIR}/deploy/kubernetes/snapshot-controller"
  # save older image
  tput setaf 2; echo "US_=$US" > "$ARTIFACT" && echo "::created artifact::"; tput sgr0
  # cleanup
  rm Dockerfile; cd -
  tput setaf 3; echo "::${THEY} was replaced by ${US} and applied::"; tput sgr0
fi
