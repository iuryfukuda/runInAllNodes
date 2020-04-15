sshuser ?= ""
pubkey ?= ""
privkey ?= ""
port ?= "22"
cmd ?= "sudo tcpdump -s256"
sshjumpversion ?= 0.3.0

setup-cache:
	./createCache $(sshuser) $(identity) $(pubkey) $(port)

run: kubectl-ssh-jump
	./main.sh

clean-%:
	rm -f *.${*}

kubectl-ssh-jump:
	curl -LO https://raw.githubusercontent.com/yokawasa/kubectl-plugin-ssh-jump/$(sshjumpversion)/kubectl-ssh-jump
	chmod +x kubectl-ssh-jump

clean: clean-pid clean-log clean-err

stop:
	@kill $(shell cat *.pid) 

runFixAllNodeAuth:
	./updateAllNodeAuth.sh -u $(sshuser) -p $(pubkey)
