clear all;
addpath('./RoombaControl')
addpath('./ros4mat/matlab')
IP = '10.248.116.252';
ros4mat('connect', IP, 1);

do = sprintf('\x30\x22'); %C
re = sprintf('\x32\x22'); %D
mi = sprintf('\x34\x22'); %E
pause = sprintf('\x00\x22'); %E

completeSong = [do do mi mi re mi re do pause do do mi mi re mi];

songCommand = sprintf('\x8C'); %140
songNumber = sprintf('\x01'); 
songLength = sprintf('\x0F');
initSong = [songCommand songNumber songLength];
% completeSong
playCommand = sprintf('\x8D');
play = [playCommand songNumber];

roombaSendMessage([initSong completeSong])
roombaSendMessage(play)
