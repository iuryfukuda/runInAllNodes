sshuser ?= ""
pubkey ?= ""
privkey ?= ""
port ?= "22"
cmd ?= "sudo tcpdump -s256"
sshjumpversion ?= b002286d774aa50fd8c9057d772c284ad5e019f6

setup-cache:
	./createCache $(sshuser) $(identity) $(pubkey) $(port)

run: kubectl-ssh-jump
	./main.sh

clean-%:
	rm -f *.${*}

kubectl-ssh-jump:
	curl -LO https://raw.githubusercontent.com/iuryfukuda/kubectl-plugin-ssh-jump/$(sshjumpversion)/kubectl-ssh-jump
	chmod +x kubectl-ssh-jump

clean: clean-pid clean-log clean-err

stop:
	@kill $(shell cat *.pid) 

runFixAllNodeAuth:
	./updateAllNodeAuth -u $(sshuser) -p $(pubkey)
