DIR='.openshift-cluster'   # Cluster metadata directory
USER='prasriva'            # RH username
CLUSTER_ID="$USER-$RANDOM" # Cluster name = <Your RH id> + $RANDOM
NAME='new\sname\shere'     # Template for Cluster ID
CONF='install-config.yaml' # Original config filename in .aws

cd ~
rm -rf "$DIR"
mkdir "$DIR"
cp .aws/"$CONF" "$DIR"/
sed -i "s/$NAME/$CLUSTER_ID/" "$DIR"/"$CONF"
openshift-install create cluster --dir="$DIR"
oc login "https://api.$CLUSTER_ID.devcluster.openshift.com:6443" -u kubeadmin -p `cat "$DIR/auth/kubeadmin-password"`
export OCP_LOGIN_STRING="oc login \"https://api.$CLUSTER_ID.devcluster.openshift.com:6443\" -u kubeadmin -p "`cat "$DIR/auth/kubeadmin-password"`
echo "${OCP_LOGIN_STRING}" >> ~/scripts/.cronjobs.log
cd -
notify-send "Cluster created: $OCP_LOGIN_STRING" -e 86400000
