#!/bin/sh

set -eu

sshuser=$1
identity=$2
pubkey=$3
port=$4

mkdir -p ${HOME}/.kube
CACHE_FILE=${HOME}/.kube/kubectlssh

cat <<EOF > $CACHE_FILE
sshuser=${sshuser}
identity=${identity}
pubkey=${pubkey}
port=${port}
EOF
