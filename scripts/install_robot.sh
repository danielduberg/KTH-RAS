#!/bin/bash --init-file

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

# Turn off notification of new Ubuntu releases
sudo sed -i 's/=lts/=never/g' /etc/update-manager/release-upgrades

# Install ROS and setup catkin workspace
wget https://raw.githubusercontent.com/danielduberg/KTH-RAS/master/scripts/install_computer.sh -O /tmp/install_computer.sh
chmod +x /tmp/install_computer.sh
bash /tmp/install_computer.sh project

# Set the Unity launcher
gsettings set com.canonical.Unity.Launcher favorites "['application://ubiquity.desktop', 'application://org.gnome.Nautilus.desktop', 'application://firefox.desktop', 'application://qtcreator.desktop', 'application://libreoffice-writer.desktop', 'application://libreoffice-calc.desktop', 'application://libreoffice-impress.dekstop', 'application://org.gnome.Software.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"

# Clean up
rm /tmp/install_computer.sh

# Source
source ~/.bashrc
