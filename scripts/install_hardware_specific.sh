#!/bin/bash

# Install realsense drivers
cd
mkdir Dev
cd ~/Dev
git clone https://github.com/KTH-RAS/librealsense-release.git
cd librealsense-release
git checkout -b rpm/ros-kinetic-librealsense-1.12.1-0_24
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
udevadm trigger
./scripts/patch-uvcvideo-ubuntu-mainline.sh
sudo modprobe uvcvideo

# Install phidget drivers
cd && sudo apt-get install libusb-1.0-0-dev
cd /tmp && wget http://www.phidgets.com/downloads/phidget21/libraries/linux/libphidget/libphidget_2.1.8.20170607.tar.gz -O libphidget.tar.gz
tar -zxvf libphidget.tar.gz
cd libphidget*
./configure
make
sudo make install
sudo cp udev/99-phidgets.rules /etc/udev/rules.d
cd

# Create udev rule for arm
touch ttyUSB.rules
echo 'KERNEL=="ttyUSB*", MODE="0666"' >> ttyUSB.rules
sudo mv ttyUSB.rules /etc/udev/rules.d

# Install pyuarm
cd ~/ 
git clone https://github.com/KTH-RAS/pyuarm.git
cd ~/pyuarm
sudo python setup.py install

# Stuff
rosdep install --skip-keys=librealsense --from-paths -i ras_realsense/realsense_camera/src/
cd ~/catkin_ws
source ~/.bashrc
catkin_make
source ~/catkin_ws/devel/setup.bash
cd ~/catkin_ws/src/ras_rplidar/scripts
sudo mv rplidar.rules /etc/udev/rules.d
sudo service udev reload
sudo service udev restart

# Install IMU
sudo apt-get install ros-kinetic-phidgets-imu ros-kinetic-imu-filter* -y

# Add user to dialout group
u=$USER
sudo adduser $u dialout
sudo adduser $u audio
sudo adduser $u video
