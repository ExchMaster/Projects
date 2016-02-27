#!/bin/bash
iptables -A INPUT -i eth0 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 9002 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 8090 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 9002 -j DNAT --to 10.0.247.254:9002
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 8090 -j DNAT --to 10.0.247.254:8090
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -j ACCEPT
iptables -A FORWARD -o eth0 -j ACCEPT
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p
/etc/init.d/procps restart
ufw --force enable