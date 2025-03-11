#!/bin/bash

# Activer le routage IP
echo 1 > /proc/sys/net/ipv4/ip_forward

# Activer le forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# NAT pour permettre aux réseaux privés d'accéder au cloud
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


# Bloquer l'accès à YouTube et Facebook pour internal_desktop (192.168.2.2)
iptables -A FORWARD -s 192.168.2.2 -d 102.132.104.35 -j REJECT
iptables -A FORWARD -s 192.168.2.2 -d 142.251.47.206 -j REJECT


# 🔄 Autoriser le ping vers Internet
iptables -A FORWARD -p icmp -j ACCEPT


# 🔒 Restreindre le trafic vers public_server (192.168.1.2)
iptables -A FORWARD -d 192.168.1.2 -p tcp --dport 80 -j ACCEPT   # Autoriser HTTP
iptables -A FORWARD -d 192.168.1.2 -p tcp --dport 443 -j ACCEPT  # Autoriser HTTPS
iptables -A FORWARD -d 192.168.1.2 -j DROP  # Bloquer tout autre trafic


# Ajouter des routes pour permettre la communication entre les réseaux locaux
iptables -A FORWARD -i eth1 -o eth2 -j REJECT
iptables -A FORWARD -i eth2 -o eth1 -j ACCEPT

# Garder le conteneur actif
exec tail -f /dev/null

