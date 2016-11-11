# 52Pi
## It contains a lot of testing code from my daily work.
## It's just for fun or just for my testing, i will put every C code and shell scripts and python scripts up here, you can just follow my steps to use your 52Pi module and development boards as well. 
##
Indexes 
###8x8 RGB matrix
1. After power on and login to system. you can open a terminal and edit /boot/config.txt file to enable SPI function.
sudo vim.tiny /boot/config.txt 
   device_tree=bcm2710-rpi-3-b.dtb
   dtparam=spi=on
2.Edit a file named it matrix.c and input following paragraph:
sudo vim.tiny matrix.c 
#include <stdio.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdint.h>

#define RED_DATA 0
#define BLUE_DATA 1
#define GREEN_DATA 2

int main(void)
{
  static uint8_t data[4] = {0x0,0x0,0x0,0x0};
  
  wiringPiSetup();
  wiringPiSPISetup(0,500000);
  while(1)
     {
         static uint8_t heart[8] = {0x00, 0x66, 0xFF, 0xFF, 0xFF, 0x7E, 0x3C, 0x18};             // this is a array of heart
         int j;
         int x=2;
    for ( j=0;j<8;j++)
        {
          data[0] = ~heart[j];
          data[2] = 0xFF;
          data[1] = 0xFF;
          data[3] = 0x01 << j ;
          wiringPiSPIDataRW(0,data,sizeof(data));              // send data to SPI channel 0, and the length of the data
          delay(x);
        };
    };
}

3.Compile it.
sudo gcc -o matrix matrix.c -lwiringPi
4.Run it.
sudo ./matrix
5.You will see it ligths up.
##
# 52Pi
