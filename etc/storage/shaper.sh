#!/bin/sh

# Originally published by viperet @ http://forum.zyxmon.org/post2617.html#p2617

# This script adjusts upload (from router to clients) speed only, br0 is upload interface
WAN=br0

# Load imq module if necessary
[ -z "$(lsmod | grep imq)" ] && insmod imq

# Clean shaper settings
tc qdisc del dev $WAN root

# Apply shaper at start only
[ "x$1" = "xstart" ] || exit

# HTB queuing discipline used, see guide at http://luxik.cdi.cz/~devik/qos/htb/manual/userg.htm
tc qdisc add dev $WAN root handle 1: htb default 90

# This is a root class. Please set guaranteed and max speed of WAN interface (50mbps)
tc class add dev $WAN parent 1: classid 1:1 htb rate 50mbit ceil 50mbit

# 1st group (one client, 192.168.1.3) settings: 5mbps guaratneed, 5mbps max
tc class add dev $WAN parent 1:1 classid 1:10 htb rate 5mbit ceil 5mbit
tc filter add dev $WAN protocol ip parent 1:0 prio 1 u32 \
    match ip dst 192.168.1.3 flowid 1:10
tc qdisc add dev $WAN parent 1:10 handle 20: pfifo limit 5

# 2nd group (two clients 192.168.1.4, 192.168.1.5) settings: 5mbps guaranteed, 10mbps max
tc class add dev $WAN parent 1:1 classid 1:11 htb rate 5mbit ceil 10mbit
tc filter add dev $WAN protocol ip parent 1:0 prio 1 u32 \
    match ip dst 192.168.1.4 flowid 1:11
tc filter add dev $WAN protocol ip parent 1:0 prio 1 u32 \
    match ip dst 192.168.1.5 flowid 1:11
tc qdisc add dev $WAN parent 1:11 handle 30: pfifo limit 5

# Other LAN clients settings: 1mbps guaranteed, 2mbps max
tc class add dev $WAN parent 1:1 classid 1:90 htb rate 1mbit ceil 2mbit
tc qdisc add dev $WAN parent 1:90 handle 99: sfq perturb 10
