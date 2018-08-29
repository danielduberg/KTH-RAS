#!/bin/bash

# setup environment
source /opt/ros/kinetic/setup.bash
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

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
