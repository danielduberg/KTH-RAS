#!/bin/bash

# Turn of automatic updates
touch 10periodic
echo 'APT::Periodic::Update-Package-Lists "0";' >> 10periodic
echo 'APT::Periodic::Download-Upgradeable-Packages "0";' >> 10periodic
echo 'APT::Periodic::AutocleanInterval "0";' >> 10periodic
echo 'APT::Periodic::Unattended-Upgrade "0";' >> 10periodic
sudo chown root:root 10periodic
sudo chmod 644 10periodic
sudo mv 10periodic /etc/apt/apt.conf.d/10periodic

touch 20auto-upgrades
echo 'APT::Periodic::Update-Package-Lists "0";' >> 20auto-upgrades
echo 'APT::Periodic::Download-Upgradeable-Packages "0";' >> 20auto-upgrades
echo 'APT::Periodic::AutocleanInterval "0";' >> 20auto-upgrades
echo 'APT::Periodic::Unattended-Upgrade "0";' >> 20auto-upgrades
sudo chown root:root 20auto-upgrades
sudo chmod 644 20auto-upgrades
sudo mv 20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

# Install ROS and setup catkin workspace
wget https://raw.githubusercontent.com/danielduberg/KTH-RAS/master/scripts/install_computer.sh
chmod +x install_computer.sh
bash ./install_computer.sh "$@"

# Clean up
rm install_computer.sh
