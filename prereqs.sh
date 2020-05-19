#!/bin/bash
# INSTALL REQUIRED PACAKAGES #
yum install -y vim git bash-completion

# DISABLE SWAP ON NODES #
sed -i 's/^\//#/' /etc/fstab
swapoff -a
