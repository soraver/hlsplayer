#!/bin/bash
url=$1
lifara=/tmp/`date +%s`.fifo
rm $lifara
mkfifo $lifara
tail -f $lifara|mplayer -loop 0 - &
last=''
while [ 1 == 1 ];do
  u=`curl -s $url|tail -1`
  if [ "$u" == "$last" ];then continue;fi
  last=$u
  echo $u
  curl -s $u >> $lifara
#  if [ `ps x|grep $lifara|wc -l` == 1];then mplayer $lifara & ;fi
#  sleep 0.3
done
