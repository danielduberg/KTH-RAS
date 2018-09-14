#!/bin/bash

# Only adds the argument to $HOME/.bashrc if the line is not there yet
addToBashrc() {
  if ! grep -qF "$1" "$HOME/.bashrc"; then
    echo "$1" >> $HOME/.bashrc
  fi
}

# Install ROS
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
 
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
 
sudo apt-get update -y
sudo apt-get install ros-kinetic-desktop-full -y
 
apt-cache search ros-kinetic
 
sudo rosdep init -y
rosdep update -y
 
# setup environment
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
