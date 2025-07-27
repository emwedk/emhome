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
	git pull
	sudo ansible-playbook -i inventory playbook.yml --tags "home,rebuild"

.PHONY: emhome
emhome:##..................Update and Fix Emhome
	sudo -s touch Makefile
	@echo "Updating and Fixing Emhome..."
	git pull
	sudo ansible-playbook -i inventory playbook.yml --tags "home"

.PHONY: missing
missing:##..................Install Missing Containers - Doesn't update
	sudo -s touch Makefile
	@echo "Installing Missing Containers..."
	git pull
	sudo ansible-playbook -i inventory playbook.yml --tags "home,missing"

.PHONY: traefik
traefik:##..................Install Traefik
	sudo -s touch Makefile
	@echo "Running Ansible playbook for Traefik"
	git pull
	sudo ansible-playbook -i inventory playbook.yml --tags "traefik,rebuild"

.PHONY: home
home:##..................Install Homeassistant
	sudo -s touch Makefile
	@echo "Running Ansible playbook for Homeassistant"
	git pull
	sudo ansible-playbook -i inventory playbook.yml --tags "homeassistant,rebuild"

.PHONY: zigbee
zigbee:##..................Install Zigbee2MQTT
	sudo -s touch Makefile
	@echo "Running Ansible playbook for Zigbee2MQTT"
	git pull
	sudo ansible-playbook -i inventory playbook.yml --tags "mosquitto,rebuild"


.PHONY: test
test:##..................tests the "test.yml" Ansible playbook
	@echo "Running Ansible playbook test"
	git pull
	sudo ansible-playbook -i inventory test.yml

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
