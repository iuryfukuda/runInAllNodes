#!/bin/sh

set -o errexit
set -o nounset

DEFAULT_USERNAME=$USER
DEFAULT_PUBKEY=$HOME/.ssh/id_rsa.pub

usage() {
    echo "usage:"
    echo "	$0 [ARGS..]"
    echo " args:"
    echo "   -h		help message"
    echo "   -u		username (default $DEFAULT_USERNAME)"
    echo "   -p		public key (default $DEFAULT_PUBKEY)"
}

err() {
    echo "err: "$@
    usage
    exit 1
}

while getopts "hu:p:" OPT; do
    case "$OPT" in
	"h") usage && exit 0;;
	"u") username=$OPTARG;;
	"p") pubkey=$OPTARG;;
	"?") exit 1;;
    esac
done

USERNAME=${username:-$DEFAULT_USERNAME}
PUBKEY=${pubkey:-$DEFAULT_PUBKEY}


[ -f $PUBKEY ] || err "not found "$PUBKEY

allNodes=$(kubectl get nodes | awk '{ print $1 }' | grep -v '^NAME$')
allResourcesJSON=$(mktemp)
az resource list > $allResourcesJSON

for node in $allNodes
do
    resource=$(jq -r  '.[]| select(.name=="'$node'") | .resourceGroup' $allResourcesJSON)
    cmd="az vm user update
       --resource-group $resource
       --name $node
       --username $username 
       --ssh-key-value $pubkey"
    echo $cmd
    eval $cmd
done

rm -f $allResourcesJSON

exit 0
