function angle = roombaAngleSensor()
% angle = roombaAngleSensor()
% Displays the angle in degrees that Create has turned since the angle was last requested.
% Counter-clockwise angles are positive and Clockwise angles are negative.

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Maxime Latulippe, Laval University, 2012

%Initialize preliminary return values
angle = nan;

roombaSendMessage([sprintf('\x8E') sprintf('\x14')])

% angle = fread(serPort, 1, 'int16');
angle = roombaReceiveMessage(1);

