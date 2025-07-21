.PHONY: em
em:
	@echo "Rebuild emhome"
	docker rm -f $$(docker ps -a -q)
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
	git pull
	sh install.sh