#!/bin/bash

# Install ROS
wget https://raw.githubusercontent.com/danielduberg/KTH-RAS/master/scripts/install_ros.sh -O /tmp/install_ros.sh
chmod +x /tmp/install_ros.sh
bash /tmp/install_ros.sh "$@"

# Setup catkin workspace
wget https://raw.githubusercontent.com/danielduberg/KTH-RAS/master/scripts/setup_catkin_ws.sh -O /tmp/setup_catkin_ws.sh
chmod +x /tmp/setup_catkin_ws.sh
bash /tmp/setup_catkin_ws.sh "$@"

# Clean up
rm /tmp/install_ros.sh /tmp/setup_catkin_ws.sh

# Source
source ~/.bashrc
