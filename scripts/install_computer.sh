#!/bin/bash

# Install ROS
wget https://raw.githubusercontent.com/danielduberg/KTH-RAS/master/scripts/install_ros.sh
chmod +x install_ros.sh
bash ./install_ros.sh "$@"

# Setup catkin workspace
wget https://raw.githubusercontent.com/danielduberg/KTH-RAS/master/scripts/setup_catkin_ws.sh
chmod +x setup_catkin_ws.sh
bash ./setup_catkin_ws.sh "$@"

# Clean up
rm install_ros.sh setup_catkin_ws.sh
