#!/bin/bash
# Function: modify the configuration of touch screen's Calibrator.
# Author: Jacky.li
# Date: 2017-04-26
#
# clear screen.
clear

# Funciton greeting.
greeting(){
dialog --backtitle "GeeekPi Touch Screen Calibrator Configure Panel" \
--msgbox "Welcome to GeeekPi Touch Screen Calibrator Configure Panel, please select your screen's Calibrator and press OK to continue.It supports 5inch 800x480 GPIO Touch Screen, 7inch 1024x600 touch screen, more information please access http://wiki.52pi.com/. Thanks" \
20 80 --begin 20 10
}

# Function yesno
yesno(){
dialog --backtitle "GeeekPi Touch Screen Calibrator Configure Panel" \
--title "Configure /boot/config.txt file" \
--clear \
--yesno "Do you agree to modify /boot/config.txt file?" 20 80
result=$?
if [ $result -eq 0 ]; then
  change_Calibrator;
  show_config_details;
elif [ $result -eq 255 ]; then
 exit 255;
fi
}

#Install some packages for touch screen calibration.
install_packages(){
  sudo apt-get update
  for x in xinput libx11-dev libxext-dev x11proto-input-dev evtest dh-autoreconf libts-bin libxi-dev
     do
        sudo apt-get -y install $x
     done
}

#Define a function to setup.
change_Calibrator(){
dialog --clear --backtitle "GeeekPi Touch Screen Calibrator Configure Panel" \
--title "Calibrator select" \
--radiolist "Please select Calibrator of your screen" 20 80 30 R1 "5inch 800x480 GPIO Touch Screen" on R2 "7inch 800x480 Touch Screen" off 2>.select
RES_NUM=$(cat .select)
case $RES_NUM in
R1)
  sudo sed -i '/^#.*framebuffer.*/s/^#//' /boot/config.txt
  sudo sed -i '/^framebuffer_width.*/s/framebuffer_width.*/framebuffer_width=800/' /boot/config.txt
  sudo sed -i '/^framebuffer_height.*/s/framebuffer_height.*/framebuffer_height=480/' /boot/config.txt
  sudo sed -i '/hdmi_force_hotplug/s/^#//' /boot/config.txt
  sudo sed -i '/hdmi_group.*/d' /boot/config.txt
  sudo sed -i '/hdmi_mode.*/d' /boot/config.txt
  sudo sed -i '/hdmi_cvt.*/d' /boot/config.txt
  sudo sed -i '/hdmi_edid_file.*/d' /boot/config.txt
  sudo sed -i '/hdmi_force/a\hdmi_group=2' /boot/config.txt
  sudo sed -i '/hdmi_force/a\hdmi_mode=87' /boot/config.txt
  sudo sed -i '/hdmi_force/a\hdmi_cvt 800 480 60 6 0 0 0' /boot/config.txt
  sudo sed -i '/hdmi_force/a\hdmi_edid_file=1' /boot/config.txt
  install_packages
  cd /home/pi
  wget http://wiki.52pi.com/images/a/af/Edid.dat.zip
  unzip /home/pi/Edid.dat.zip
  sudo mv -f /home/pi/edid.dat /boot/
  git clone https://github.com/tias/xinput_calibrator.git
  cd /home/pi/xinput_calibrator/
  sudo bash autogen.sh
  sudo make
  sudo make install
  sudo mkdir -p /etc/X11/xorg.conf.d/
  FRAMEBUFFER=/dev/fb1 DISPLAY=:0.0 xinput_calibrator > /etc/X11/xorg.conf.d/99-calibration.conf
  sudo sed -i '1,7s/^/#/' /etc/X11/xorg.conf.d/99-calibration.conf
   ;;
R2)
  sudo sed -i '/^#.*framebuffer.*/s/^#//' /boot/config.txt
  sudo sed -i '/^framebuffer_width.*/s/framebuffer_width.*/framebuffer_width=800/' /boot/config.txt
  sudo sed -i '/^framebuffer_height.*/s/framebuffer_height.*/framebuffer_height=480/' /boot/config.txt
  sudo sed -i '/hdmi_force_hotplug/s/^#//' /boot/config.txt
  sudo sed -i '/hdmi_group.*/d' /boot/config.txt
  sudo sed -i '/hdmi_mode.*/d' /boot/config.txt
  sudo sed -i '/hdmi_cvt.*/d' /boot/config.txt
  sudo sed -i '/hdmi_force/a\hdmi_group=2' /boot/config.txt
  sudo sed -i '/hdmi_force/a\hdmi_mode=87' /boot/config.txt
  sudo sed -i '/hdmi_force/a\hdmi_cvt 800 480 60 6 0 0 0' /boot/config.txt
   ;;
*)
exit 255
esac
}

show_config_details(){
dialog --backtitle "GeeekPi Touch Screen Calibrator Configure Panel" --textbox "/boot/config.txt" 20 80
}

clear_window(){
dialog --msgbox "Configuration is compelete!" 20 80 --begin 10 70 --yesno "Do you want to reboot your system?" 20 60
if [ $? -eq 0 ];then
   sudo sync && sudo reboot
elif [ $? -eq 255 ];then
   exit 255
fi
dialog --clear
}
# Call greeting and yesno.
greeting
yesno
show_details
clear_window
rm -rf .select
clear
##End of file##
