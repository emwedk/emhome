# include .env

help:##..................Show the help
	@echo ""
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//' | sed 's/^/    /'
	@echo ""

.PHONY: em
em:##..................
	sudo -s touch Makefile
	@echo "Rebuild emhome"
	docker rm -f $$(docker ps -a -q) || true
	docker network prune -f
	sudo rm -rf /opt/traefik
	sudo rm -rf /opt/containerd
	sudo rm -rf /opt/duckdns
	sudo rm -rf /opt/esphome
	sudo rm -rf /opt/grafana
	sudo rm -rf /opt/homeassistant
	sudo rm -rf /opt/mosquitto
	sudo rm -rf /opt/node-red
	sudo rm -rf /opt/portainer
	sudo rm -rf /opt/zigbee2mqtt
	sudo rm -rf /var/log/traefik
	sudo rm -rf /var/log/containerd
	sudo rm -rf /var/log/duckdns
	sudo rm -rf /var/log/esphome
	sudo rm -rf /var/log/grafana
	sudo rm -rf /var/log/homeassistant
	sudo rm -rf /var/log/mosquitto
	sudo rm -rf /var/log/node-red
	sudo rm -rf /var/log/portainer
	sudo rm -rf /var/log/zigbee2mqtt
	git pull
	sudo ansible-playbook -i inventory playbook.yml
# 	sh install.sh

.PHONY: traefik
traefik:##..................Install Traefik
	@echo "Running Ansible playbook for Traefik"
	git pull
	sudo ansible-playbook -i inventory traefik.yml --tags "traefik"

.PHONY: test
test:##..................tests the "test.yml" Ansible playbook
	@echo "Running Ansible playbook test"
	git pull
	sudo ansible-playbook -i inventory test.yml --check --diff

.PHONY: cull
cull:##..................Remove all containers
	docker rmi -f $$(docker images -a) || true

.PHONY: install-ansible
install-ansible:##..................Install Ansible if not already installed
	shift
	@if ! ansible --version >/dev/null 2>&1; then \
		echo "Installing Ansible"; \
		sudo apk add --no-interactive --no-cache ansible; \
		if [ $$? -ne 0 ]; then \
			echo "Failed to install Ansible. Exiting."; \
			exit 1; \
		fi \
	fi
