#!/bin/bash

set -x

sudo apt-get update
sudo apt-get install -y quagga

echo "net.ipv4.conf.all.forwarding=1" | sudo tee -a /etc/sysctl.conf 
echo "net.ipv4.conf.default.forwarding=1" | sudo tee -a /etc/sysctl.conf 
sudo sysctl -p

sudo cp /vagrant/configs/linux_box_1/*  /etc/quagga/

chown -Rf quagga:quagga /etc/quagga/*


sudo sed -i "s/zebra=no/zebra=yes/" /etc/quagga/daemons 
sudo sed -i "s/bgpd=no/bgpd=yes/" /etc/quagga/daemons 
#sudo sed -i "s/ospfd=no/ospfd=yes/" /etc/quagga/daemons 

sudo adduser vagrant quagga
sudo /etc/init.d/quagga restart


sudo chmod 666 /etc/bash.bashrc
echo "export VTYSH_PAGER=more" >> /etc/bash.bashrc
