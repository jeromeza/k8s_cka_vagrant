#!/bin/bash
# INSTALL REQUIRED PACAKAGES #
yum install -y vim git bash-completion

# DISABLE SWAP ON NODES #
sed -i 's/^\//#/' /etc/fstab
swapoff -a

# SET TEMP + PERSISTENT ROUTE FOR K8S TO OVERRIDE VAGRANT DEFAULTS #
if [ "$HOSTNAME" != control.example.com ]; then
    echo "ip route add 10.96.0.0/16 dev eth1" > /etc/rc.local && chmod +x /etc/rc.local
    ip route add 10.96.0.0/16 dev eth1
else
    printf '%s\n' "Master node, do nothing"
fi
