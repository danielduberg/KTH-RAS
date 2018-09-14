#!/bin/bash

# Only adds the argument to $HOME/.bashrc if the line is not there yet
addToBashrc() {
  if ! grep -qF "$1" "$HOME/.bashrc"; then
    echo "$1" >> $HOME/.bashrc
  fi
}

# Check correct number of arguments
if [ "$#" -gt "1" ]; then
  (>&2 echo "You should only supply one argument")
  exit 1
elif [ "$#" -lt "1" ]; then
  (>&2 echo "You should supply one argument")
  exit 2
fi
# Check correct argument value
if [ "$1" != "lab" ] && [ "$1" != "project" ] && [ "$1" != "both" ]; then
  (>&2 echo "Argument should be one of: 'lab', 'project', or 'both'")
  exit 3
fi

# create catkin ws
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src

# setup environment
addToBashrc "source /opt/ros/kinetic/setup.bash"
source ~/.bashrc

# Init workspace
catkin_init_workspace
wstool init
 
# merge rosinstall files
cd ~/catkin_ws/src
if [ "$1" = "lab" ] || [ "$1" = "both" ]; then
  wget https://raw.githubusercontent.com/danielduberg/KTH-RAS/master/rosinstall/lab.rosinstall
  wstool merge lab.rosinstall
  # Clean up
  rm lab.rosinstall
fi
if [ "$1" = "project" ] || [ "$1" = "both" ]; then
  wget https://raw.githubusercontent.com/danielduberg/KTH-RAS/master/rosinstall/project.rosinstall
  wstool merge project.rosinstall
  # Clean up
  rm project.rosinstall
fi
wstool update

# Build and source
cd ~/catkin_ws
catkin_make
addToBashrc "source ~/catkin_ws/devel/setup.bash"
source ~/.bashrc
