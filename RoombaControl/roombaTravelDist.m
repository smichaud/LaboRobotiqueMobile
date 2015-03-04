function roombaTravelDist(roombaSpeed, distance)
%travelDist(serPort, roombaSpeed, distance)
%Moves the Create the distance entered in meters. Positive distances move the
%Create foward, negative distances move the Create backwards.
%roombaSpeed should be between 0.025 and 0.5 m/s
% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Maxime Latulippe, Laval University, 2012


if (roombaSpeed < 0) %Speed given by user shouldn't be negative
    disp('WARNING: Speed inputted is negative. Should be positive. Taking the absolute value');
    roombaSpeed = abs(roombaSpeed);
end

if (abs(roombaSpeed) < .025) %Speed too low
    disp('WARNING: Speed inputted is too low. Setting speed to minimum, 0.025 m/s');
    roombaSpeed = .025;
end
if (abs(roombaSpeed) > .5) %Speed too high
    disp('WARNING: Speed inputted is too high. Setting speed to maximum, 0.5 m/s');
    roombaSpeed = .5;
end

if (distance < 0) %Definition of SetFwdVelRAdius Roomba, speed has to be negative to go backwards. Takes care of this case. User shouldn't worry about negative speeds
    roombaSpeed = -1 * roombaSpeed;
end

if (distance ~=0)
    roombaSetFwdVelRadius(roombaSpeed, inf);
    distanceMM = distance * 1000;
    roombaSendMessage([sprintf('\x9C') IntToHex(distanceMM)])
    roombaSetFwdVelRadius(0, 0);
end
