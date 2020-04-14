#!/bin/sh

set -o errexit
set -o nounset

DEFAULT_USERNAME=$USER
DEFAULT_PUBKEY=$HOME/.ssh/id_rsa.pub

usage() {
    echo "usage:"
    echo "      $0 [args] <cmd>"
    echo " args:"
    echo "   -h         help message"
}

err() {
    echo "err: "$@
    usage
    exit 1
}

case $1 in
  "-h" | "--help")
    usage
    exit 0
    ;;
esac

cmd=${@-""}

[ -z $cmd ] && err "cmd not setted"

allNodes=$(kubectl get nodes | awk '{ print $1 }' | grep -v '^NAME$')

for node in $allNodes
do
  ./kubectl-ssh-jump $node -a "$cmd" 1> $node.log 2> $node.err &
  pid=$!
  echo $pid > $node.pid
  ## must sure the process is loaded before start next
  while ! grep -q $cmd $node.log
  do
    sleep 3
  done
done
