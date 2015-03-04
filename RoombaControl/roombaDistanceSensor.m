function distance = roombaDistanceSensor()
% distance = roombaDistanceSensor()
% Gives the distance traveled in meters since last requested. Positive
% values indicate travel in the forward direction. Negative values indicate
% travel in the reverse direction. If not polled frequently enough, it is
% capped at its minimum or maximum of +/- 32.768 meters.

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Maxime Latulippe, Laval University, 2012

%Initialize preliminary return values
distance = nan;

roombaSendMessage([sprintf('\x8E') sprintf('\x13')])

% distance = fread(serPort, 1, 'int16')/1000;
distance = roombaReceiveMessage(1) / 1000;
if (distance > 32) | (distance <-32)
    disp('Warning:  May have overflowed')
end

