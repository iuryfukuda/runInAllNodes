# Run inside all Nodes

Script for runn a command inside all kubectl nodes with an command and get logs.  
   
## How it works

It will Iterate over a `kubectl get nodes`  
it will be access every node with [ssh-jump](https://github.com/yokawasa/kubectl-plugin-ssh-jump) and interate
Run the cmd givenned inside all nodes and log it
   
## Log files

For each pod it will generate:
- {node}.log: give the mainly log
- {node}.pid: pid of the capture process
- {node}.err: stderr output

## Required

Is necessary the privatekey, pubkey and the username used in your node access for the ssh-jump works first time.
After this, this will cache and it is not more necessary.
see more in: https://github.com/yokawasa/kubectl-plugin-ssh-jump

## Setup

Create cache file with sshuser configs

``` shell
make setup-cache sshuser=username identity=$HOME/.ssh/id_rsa pubkey=$HOME/.ssh/id_rsa.pub
```

## Usage

Run with default cmd
``` shell
make run
```

Pass custom cmd by `cmd` var and run by `make run`

``` shell
make run cmd="sudo tcpdump -vv tcp port (443 or 80)"
```

Run by main.sh
``` shell
$ ./main.sh -h
usage:
      ./main.sh [args] <cmd>
 args:
   -h         help message
```

## Fix nodes access in Azure

If you don't have access in node, you can fix this with a workarround.  

you need to have an pubkey and an username to pass and it will interate in all nodes and update you access with `az` cli  

required `kubectl` and `az` working.

``` shell
make runFixAllNodeAuth sshuser="username" pubkey="$HOME/.ssh/username_rsa.pub"
```
