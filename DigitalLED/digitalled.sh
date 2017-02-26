#!/bin/bash
# Function: digitalLED test.
# Author: Jacky.li
# Date: 2017.02.26
# 

#define the digital number.
# 0 - a,b,c,d,e,f 
# 1 - b,c
# 2 - a,b,d,e,g 
# 3 - a,b,c,d,g 
# 4 - b,c,f,g 
# 5 - a,c,d,f,g 
# 6 - a,c,d,e,f,g
# 7 - a,b,c
# 8 - a,b,c,d,e,f,g 
# 9 - a,b,c,d,f,g
# a - a,b,c,e,f,g
# b - c,d,e,f,g
# c - a,d,e,f 
# d - b,c,d,e,g 
# e - a,d,e,f,g
# f - a,e,f,g 

#define GPIO pin to led Pin mapping.
A=1
B=4
C=5
D=6
E=26
F=27
G=28
H=29

#定义个初始化函数，有点儿像arduino里面的setup()
function init_led() {
	for i in ${A} ${B} ${C} ${D} ${E} ${F} ${G} ${H}
          do 
	    gpio mode $i OUTPUT
          done 
}

function turnoff() {
	for i in ${A} ${B} ${C} ${D} ${E} ${F} ${G} ${H} 
          do 
	    gpio write  $i 0
            echo -e "$i \033[32;40mturned off\033[0m"
          done 
}

function zero() {
	for i in ${A} ${B} ${C} ${D} ${E} ${F}
          do 
	    gpio write $i 1
          done 
}

function one() {
	for i in ${B} ${C}
          do 
	    gpio write $i 1
          done 
}

function two() {
	for i in ${A} ${B} ${D} ${E} ${G}
          do 
	    gpio write $i 1
          done 
}

function three() {
	for i in ${A} ${B} ${C} ${D} ${G}
          do 
	    gpio write $i 1
          done 
}

function four() {
	for i in ${B} ${C} ${F} ${G}
          do 
	    gpio write $i 1
          done 
}
function five() {
	for i in ${A} ${C} ${D} ${F} ${G}
          do 
	    gpio write $i 1
          done 
}
function six() {
	for i in ${A} ${C} ${D} ${E} ${F} ${G}
          do 
	    gpio write $i 1
          done 
}
function seven() {
	for i in ${A} ${B} ${C} 
          do 
	    gpio write $i 1
          done 
}
function eight() {
	for i in ${A} ${B} ${C} ${D} ${E} ${F} ${G} 
          do 
	    gpio write $i 1
          done 
}
function eight() {
	for i in ${A} ${B} ${C} ${D} ${E} ${F} ${G} 
          do 
	    gpio write $i 1
          done 
}
function nine() {
	for i in ${A} ${B} ${C} ${D} ${F} ${G} 
          do 
	    gpio write $i 1
          done 
}
function CA() {
	for i in ${A} ${B} ${C} ${E} ${F} ${G} 
          do 
	    gpio write $i 1
          done 
}
function CB() {
	for i in ${C} ${D} ${E} ${F} ${G} 
          do 
	    gpio write $i 1
          done 
}

function dot() {
         gpio write 29 1 
         sleep 0.5
         gpio write 29 0
         sleep 0.5
}

while true
do 
init_led
zero
sleep 1
dot
turnoff

one
sleep 1 
dot
turnoff

two
sleep 1 
dot
turnoff

three
sleep 1 
dot
turnoff

four
sleep 1
dot
turnoff

five 
sleep 1 
dot
turnoff

six
sleep 1
dot
turnoff

seven
sleep 1 
dot
turnoff

eight
sleep 1
dot
turnoff

nine
sleep 1
dot
turnoff

CA
sleep 1
dot
turnoff

done
