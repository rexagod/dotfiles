set -e

minikube start
minikube addons enable olm

make generate
make manifests
make build
COMMIT="git add . && git commit --amend"
`${COMMIT}`
export QUAY_DOCKER_NAMESPACE="rexagod"
export IMAGE_TAG="latest"
echo "Ensure your images are public!"
make REGISTRY_NAMESPACE=${QUAY_DOCKER_NAMESPACE} IMAGE_TAG=${IMAGE_TAG} docker-build
make REGISTRY_NAMESPACE=${QUAY_DOCKER_NAMESPACE} IMAGE_TAG=${IMAGE_TAG} docker-push
make REGISTRY_NAMESPACE=${QUAY_DOCKER_NAMESPACE} IMAGE_TAG=${IMAGE_TAG} bundle 
`${COMMIT}`
make REGISTRY_NAMESPACE=${QUAY_DOCKER_NAMESPACE} IMAGE_TAG=${IMAGE_TAG} bundle-build
make REGISTRY_NAMESPACE=${QUAY_DOCKER_NAMESPACE} IMAGE_TAG=${IMAGE_TAG} bundle-push
make REGISTRY_NAMESPACE=${QUAY_DOCKER_NAMESPACE} IMAGE_TAG=${IMAGE_TAG} catalog-build
make REGISTRY_NAMESPACE=${QUAY_DOCKER_NAMESPACE} IMAGE_TAG=${IMAGE_TAG} catalog-push

cat << EOF | kubectl apply -f -
---
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.4.1
  creationTimestamp: null
  name: drpolicies.ramendr.openshift.io
spec:
  group: ramendr.openshift.io
  names:
    kind: DRPolicy
    listKind: DRPolicyList
    plural: drpolicies
    singular: drpolicy
  scope: Cluster
  versions:
  - name: v1alpha1
    schema:
      openAPIV3Schema:
        description: DRPolicy is the Schema for the drpolicies API
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation
              of an object. Servers should convert recognized schemas to the latest
              internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this
              object represents. Servers may infer this from the endpoint the client
              submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          spec:
            description: DRPolicySpec defines the desired state of DRPolicy
            properties:
              drClusterSet:
                description: The set of managed clusters governed by this policy,
                  which have replication relationship enabled between them.
                items:
                  description: Managed cluster information
                  properties:
                    name:
                      description: Name of this managed cluster as configured in OCM/ACM
                      type: string
                    s3ProfileName:
                      description: S3 profile name (in Ramen config) to use as a source
                        to restore PV related cluster state during recovery or relocate
                        actions of applications to this managed cluster;  hence, this
                        S3 profile should be available to successfully move the workload
                        to this managed cluster.  For applications that are active
                        on this managed cluster, their PV related cluster state is
                        stored to S3 profiles of all other managed clusters in the
                        same DRPolicy to enable recovery or relocate actions on those
                        managed clusters.
                      type: string
                  required:
                  - name
                  - s3ProfileName
                  type: object
                type: array
              replicationClassSelector:
                description: Label selector to identify all the VolumeReplicationClasses.
                  This selector is assumed to be the same for all subscriptions that
                  need DR protection. It will be passed in to the VRG when it is created
                properties:
                  matchExpressions:
                    description: matchExpressions is a list of label selector requirements.
                      The requirements are ANDed.
                    items:
                      description: A label selector requirement is a selector that
                        contains values, a key, and an operator that relates the key
                        and values.
                      properties:
                        key:
                          description: key is the label key that the selector applies
                            to.
                          type: string
                        operator:
                          description: operator represents a key's relationship to
                            a set of values. Valid operators are In, NotIn, Exists
                            and DoesNotExist.
                          type: string
                        values:
                          description: values is an array of string values. If the
                            operator is In or NotIn, the values array must be non-empty.
                            If the operator is Exists or DoesNotExist, the values
                            array must be empty. This array is replaced during a strategic
                            merge patch.
                          items:
                            type: string
                          type: array
                      required:
                      - key
                      - operator
                      type: object
                    type: array
                  matchLabels:
                    additionalProperties:
                      type: string
                    description: matchLabels is a map of {key,value} pairs. A single
                      {key,value} in the matchLabels map is equivalent to an element
                      of matchExpressions, whose key field is "key", the operator
                      is "In", and the values array contains only "value". The requirements
                      are ANDed.
                    type: object
                type: object
              schedulingInterval:
                description: scheduling Interval for replicating Persistent Volume
                  data to a peer cluster. Interval is typically in the form <num><m,h,d>.
                  Here <num> is a number, 'm' means minutes, 'h' means hours and 'd'
                  stands for days.
                type: string
            required:
            - drClusterSet
            - schedulingInterval
            type: object
          status:
            description: 'DRPolicyStatus defines the observed state of DRPolicy INSERT
              ADDITIONAL STATUS FIELD - define observed state of cluster Important:
              Run "make" to regenerate code after modifying this file'
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
status:
  acceptedNames:
    kind: ""
    plural: ""
  conditions: []
  storedVersions: []
EOF

cat << EOF | kubectl apply -f -
apiVersion: ramendr.openshift.io/v1alpha1
kind: DRPolicy
metadata:
  name: drpolicy-sample
spec:
  schedulingInterval: "1h"  # hourly
  replicationClassSelector:
    matchLabels:
      class: ramen
  drClusterSet:
    - name: east
      s3ProfileName: s3-profile-of-east
    - name: west
      s3ProfileName: s3-profile-of-west
EOF

cat << EOF | kubectl apply -f -
apiVersion: operators.coreos.com/v1alpha1            
kind: CatalogSource      
metadata:
  name: odf-orchestrator
  namespace: olm      
spec:
  displayName: ODF Multicluster Orchestrator
  icon:                              
    base64data: PHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxOTIgMTQ1Ij48ZGVmcz48c3R5bGU+LmNscy0xe2ZpbGw6I2UwMDt9PC9zdHlsZT48L2RlZnM+PHRpdGxlPlJlZEhhdC1Mb2dvLUhhdC1Db2xvcjwvdGl0bGU+PHBhdGggZD0iTTE1Ny43Nyw2Mi42MWExNCwxNCwwLDAsMSwuMzEsMy40MmMwLDE0Ljg4LTE4LjEsMTcuNDYtMzAuNjEsMTcuNDZDNzguODMsODMuNDksNDIuNTMsNTMuMjYsNDIuNTMsNDRhNi40Myw2LjQzLDAsMCwxLC4yMi0xLjk0bC0zLjY2LDkuMDZhMTguNDUsMTguNDUsMCwwLDAtMS41MSw3LjMzYzAsMTguMTEsNDEsNDUuNDgsODcuNzQsNDUuNDgsMjAuNjksMCwzNi40My03Ljc2LDM2LjQzLTIxLjc3LDAtMS4wOCwwLTEuOTQtMS43My0xMC4xM1oiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMjcuNDcsODMuNDljMTIuNTEsMCwzMC42MS0yLjU4LDMwLjYxLTE3LjQ2YTE0LDE0LDAsMCwwLS4zMS0zLjQybC03LjQ1LTMyLjM2Yy0xLjcyLTcuMTItMy4yMy0xMC4zNS0xNS43My0xNi42QzEyNC44OSw4LjY5LDEwMy43Ni41LDk3LjUxLjUsOTEuNjkuNSw5MCw4LDgzLjA2LDhjLTYuNjgsMC0xMS42NC01LjYtMTcuODktNS42LTYsMC05LjkxLDQuMDktMTIuOTMsMTIuNSwwLDAtOC40MSwyMy43Mi05LjQ5LDI3LjE2QTYuNDMsNi40MywwLDAsMCw0Mi41Myw0NGMwLDkuMjIsMzYuMywzOS40NSw4NC45NCwzOS40NU0xNjAsNzIuMDdjMS43Myw4LjE5LDEuNzMsOS4wNSwxLjczLDEwLjEzLDAsMTQtMTUuNzQsMjEuNzctMzYuNDMsMjEuNzdDNzguNTQsMTA0LDM3LjU4LDc2LjYsMzcuNTgsNTguNDlhMTguNDUsMTguNDUsMCwwLDEsMS41MS03LjMzQzIyLjI3LDUyLC41LDU1LC41LDc0LjIyYzAsMzEuNDgsNzQuNTksNzAuMjgsMTMzLjY1LDcwLjI4LDQ1LjI4LDAsNTYuNy0yMC40OCw1Ni43LTM2LjY1LDAtMTIuNzItMTEtMjcuMTYtMzAuODMtMzUuNzgiLz48L3N2Zz4=
    mediatype: image/svg+xml
  image: quay.io/rexagod/odf-multicluster-orchestrator-catalog:latest 
  publisher: Red Hat
  sourceType: grpc
---
apiVersion: operators.coreos.com/v1alpha1            
kind: Subscription       
metadata:
  name: odf-orchestrator
  namespace: olm     
spec:
  channel: alpha       
  name: odf-multicluster-orchestrator
  source: odf-orchestrator
  sourceNamespace: olm
EOF

sleep 2m

cat << EOF | kubectl apply -f -
apiVersion: multicluster.odf.openshift.io/v1alpha1
kind: MirrorPeer
metadata:
  name: mirrorpeer-sample
spec:
  items:
  - clusterName: foo
    storageClusterRef:
      name: storagecluster-1
      namespace: openshift-storage
  - clusterName: bar
    storageClusterRef:
      name: storagecluster-2
      namespace: openshift-storage
EOF