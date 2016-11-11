#!/bin/bash
#Edit /boot/config.txt file with vim.tiny or other editor. and modify as following:
sudo mv /boot/config.txt{,.bak} 
sudo cat > /boot/config.txt << EOF
framebuffer_width=800
framebuffer_height=600
dpi_group=2
device_tree=bcm2710-rpi-3-b.dtb
dpi_mode=86
dtparam=i2c_arm=off
dtparam=spi=off
dtparam=uart0=off
dtparam=uart1=off
dtoverlay=pi3-disable-bt-overlay
dtoverlay=vga666
enable_dpi_lcd=1
display_default_lcd=1
force_pwm_open=0
dtparam=audio=on
start_x=1
gpu_mem=128
EOF
sudo sync
sudo sync
#And reboot your Pi. 
echo "Configuration is ok, your RPi will reboot in 5 seconds"
sleep 5 
sudo reboot

