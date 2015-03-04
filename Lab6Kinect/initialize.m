clc
clearvars

addpath('../RoombaControl')
addpath('../ros4mat/matlab')

IP = '10.248.231.252';
ros4mat('connect', IP, 1);