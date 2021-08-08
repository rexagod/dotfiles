cd $GOPATH/src/github.com/openshift/ocs-operator

# make gen-latest-csv

make ocs-operator
podman push "quay.io/${REGISTRY_NAMESPACE}/ocs-operator:${IMAGE_TAG}"

# make operator-bundle
# podman push quay.io/$REGISTRY_NAMESPACE/ocs-operator-bundle:$IMAGE_TAG

# make operator-index
# podman push quay.io/$REGISTRY_NAMESPACE/ocs-operator-index:$IMAGE_TAG

# oc create ns openshift-storage

# cat <<EOF | oc apply -f -
# apiVersion: operators.coreos.com/v1alpha2
# kind: OperatorGroup
# metadata:
#   name: openshift-storage-operatorgroup
#   namespace: openshift-storage
# spec:
#   targetNamespaces:
#     - openshift-storage
# EOF

# cat <<EOF | oc apply -f -
# apiVersion: operators.coreos.com/v1alpha1
# kind: CatalogSource
# metadata:
#   name: ocs-catalogsource
#   namespace: openshift-marketplace
# spec:
#   sourceType: grpc
#   image: quay.io/$REGISTRY_NAMESPACE/ocs-operator-index:$IMAGE_TAG
#   displayName: OpenShift Container Storage
#   publisher: Red Hat
# EOF

# cat <<EOF | oc apply -f -
# apiVersion: operators.coreos.com/v1alpha1
# kind: Subscription
# metadata:
#   name: ocs-subscription
#   namespace: openshift-storage
# spec:
#   channel: alpha
#   name: ocs-operator
#   source: ocs-catalogsource
#   sourceNamespace: openshift-marketplace
# EOF
