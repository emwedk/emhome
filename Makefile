.PHONY: em install-ansible
em:
	@echo "Rebuild emhome"
	docker rm -f $$(docker ps -a -q) || true
	docker network prune -f
	sudo -s rm -rf /opt/traefik
	sudo rm -rf /opt/containerd
	sudo rm -rf /opt/duckdns
	sudo rm -rf /opt/esphome
	sudo rm -rf /opt/grafana
	sudo rm -rf /opt/homeassistant
	sudo rm -rf /opt/mosquitto
	sudo rm -rf /opt/node-red
	sudo rm -rf /opt/portainer
	sudo rm -rf /opt/zigbee2mqtt
	git pull
	sudo ansible-playbook -i inventory playbook.yml "$@"
# 	sh install.sh



install-ansible:
	@if ! ansible --version >/dev/null 2>&1; then \
		echo "Installing Ansible"; \
		sudo apk add --no-interactive --no-cache ansible; \
		if [ $$? -ne 0 ]; then \
			echo "Failed to install Ansible. Exiting."; \
			exit 1; \
		fi \
	fi
	echo "Installing Emhome with Ansible ..."
