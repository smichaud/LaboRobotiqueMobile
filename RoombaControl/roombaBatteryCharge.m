function [charge, capacity, percent] = roombaBatteryCharge()
% Displays the current percent charge remaining in Create's Battery 

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Maxime Latulippe, Laval University, 2012

%Initialize preliminary return values
charge = nan;
capacity = nan;
percent = nan;

roombaSendMessage([sprintf('\x8E') sprintf('\x19')])

% Charge =  fread(serPort, 1, 'uint16');
charge = roombaReceiveMessage(1);

roombaSendMessage([sprintf('\x8E') sprintf('\x19')])
% Capacity =  fread(serPort, 1, 'uint16');
capacity = roombaReceiveMessage(1);

percent = charge/capacity * 100;

