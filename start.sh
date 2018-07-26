#!/bin/bash

VPN_PSK="proscend"

if [ -e "vpn.env" ]; then
    source vpn.env
    echo sourcing vpn.env
fi

(
cat <<EOF
conn %default
    dpdaction=restart
    closeaction=restart
    keyingtries=%forever
    keyexchange=ikev1
    ike=aes128-sha1-modp1536
    lifetime=3600
    esp=aes128-sha1-modp1536
    dpddelay=30s
    dpdtimeout=150s
    authby=secret

conn conn_1
    auto=add
    leftsubnet=0.0.0.0/0
    right=%any
    rightsubnet=192.168.1.0/24
    dpdaction=clear

conn conn_2
    auto=add
    leftsubnet=0.0.0.0/0
    right=%any
    rightsubnet=192.168.2.0/24
    dpdaction=clear

conn conn_3
    auto=add
    leftsubnet=0.0.0.0/0
    right=%any
    rightsubnet=192.168.3.0/24
    dpdaction=clear
EOF
) > ipsec.conf.tmp

if [ -e ipsec.conf ]; then
    rm -f ipsec.conf.tmp
    echo "Use the existed ipsec.conf"
else
    mv ipsec.conf.tmp ipsec.conf
fi

(
cat <<EOF
: PSK "$VPN_PSK"
EOF
) > ipsec.secrets

(
cat <<EOF
IPsec configuration: ipsec.conf
IPsec secrets: ipsec.secrets
Pre-shared Key: $VPN_PSK
EOF
)

sudo docker-compose down; sudo docker-compose up -d
