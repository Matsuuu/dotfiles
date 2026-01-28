apt:
	ansible-playbook ./playbooks/apt.yml --user root -i ./inventory/hosts
create-user:
	ansible-playbook ./playbooks/create-user.yml --user root -i ./inventory/hosts
harden-ssh:
	ansible-playbook ./playbooks/harden-ssh.yml --user root -i ./inventory/hosts
ufw-ssh:
	ansible-playbook ./playbooks/ufw-ssh-only.yml --user root -i ./inventory/hosts
docker:
	ansible-playbook ./playbooks/docker.yml -i ./inventory/hosts
npm:
	ansible-playbook ./playbooks/nvm-npm.yml -i ./inventory/hosts
dotfiles:
	ansible-playbook ./playbooks/dotfiles.yml -i ./inventory/hosts
works:
	ansible-playbook ./playbooks/the-works.yml -i ./inventory/hosts
caddy:
	ansible-playbook ./playbooks/caddy.yml -i ./inventory/hosts
	
