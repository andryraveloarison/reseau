#!/bin/bash

# Définir la passerelle en fonction du réseau
if [[ "$HOSTNAME" == "public_server" ]]; then
	ip route del default via 192.168.1.1
    ip route add default via 192.168.1.10
elif [[ "$HOSTNAME" == "internal_desktop" ]]; then
	ip route del default via 192.168.2.1
    ip route add default via 192.168.2.10
elif [[ "$HOSTNAME" == "internal_server" ]]; then
	ip route del default via 192.168.2.1
    ip route add default via 192.168.2.10
fi

# Lancer un shell interactif pour garder le conteneur actif
exec tail -f /dev/null

