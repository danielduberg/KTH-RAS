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

# install ros
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
 
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
 
sudo apt-get update -y
sudo apt-get install ros-kinetic-desktop-full -y
 
apt-cache search ros-kinetic
 
sudo rosdep init -y
rosdep update -y
 
# setup environment
source /opt/ros/kinetic/setup.bash
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
 
# install build-essential
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential -y
 
# install editors/ ssh
sudo apt-get install ssh emacs qtcreator vim git -y
 
# install ros packages and other dependencies
sudo apt-get install ros-kinetic-sound-play ros-kinetic-rqt-graph ros-kinetic-rqt-gui ros-kinetic-rqt-plot ros-kinetic-kobuki-soft ros-kinetic-kobuki-keyop ros-kinetic-roscpp-tutorials ros-kinetic-librealsense ros-kinetic-rgbd-launch ros-kinetic-cmake-modules ros-kinetic-camera-info-manager -y
 
sudo apt-get install libboost-random1.58-dev openjdk-8-jre ipython -y
 
# pip wstool and git
sudo apt-get install git python-pip -y
 
sudo pip install wstool
 
# create catkin ws
 
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
 
catkin_init_workspace
wstool init
 
cd ~/catkin_ws
catkin_make
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/catkin_ws/devel/setup.bash
source ~/.bashrc
 
# merge rosinstall files
cd ~/catkin_ws/src
 
wget https://raw.githubusercontent.com/KTH-RAS/ras_install/kinetic-2018/rosinstall/vm.rosinstall
wstool merge vm.rosinstall
wstool update
 
cd ~/catkin_ws
source ~/.bashrc
catkin_make
source ~/catkin_ws/devel/setup.bash
