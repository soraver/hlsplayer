#!/bin/bash
url=$1
lifara=/tmp/`date +%s`.fifo
rm $lifara
mkfifo $lifara
mplayer $lifara &
last=''
while [ 1 == 1 ];do
  u=`curl -s $url|tail -1`
  if [ "$u" == "$last" ];then continue;fi
  last=$u
  curl -s $u >> $lifara
#  sleep 1
done
