#!/usr/bin/env python
#  -*- coding:utf-8 -*-
# Author: Jacky.li
# Date: 2017-02-23

import urllib
import json
import os
import time
os.system("sudo apt-get update && sudo apt-get install mplayer")
songname = raw_input('请输入歌名:')
songurl = 'http://s.music.163.com/search/get/?type=1&s=%s&limit=9' %songname
def get_music():
    #html = urllib.urlopen('http://s.music.163.com/search/get/?type=1&s=%E6%B5%B7%E9%98%94%E5%A
4%A9%E7%A9%BA&limit=9').read()
    html = urllib.urlopen(songurl).read()
    text = json.loads(html)
    return text

a = get_music()
music_list = []
for i in a["result"]["songs"]:
    music_list.append(i['audio'])
    #print music_list

for url in music_list:
    print url
    time.sleep(2)
    os.system("mplayer %s" %url)

