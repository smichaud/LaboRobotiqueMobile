function roombaTurnAngle(roombaSpeed, turnAngle)
%roombaTurnAngle(roombaSpeed, turnAngle)
%Turns the Create by turnAngle degrees or the shortest equivalent degree.
%roombaSpeed should be between 0 and 0.2 m/s
% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Maxime Latulippe, Laval University, 2012

if (roombaSpeed < 0) %Speed shouldn't be negative
    disp('WARNING: Speed inputted is negative. Should be positive. Taking the absolute value');
    roombaSpeed = abs(roombaSpeed);
end

if (abs(roombaSpeed) < .025) %Speed inputted is too low
    disp('WARNING: Speed inputted is too low. Setting speed to minimum, .025 m/s');
    roombaSpeed = .025;
end
if (abs(roombaSpeed) > .2) %Speed too high
    disp('WARNING: Speed inputted is too high. Setting speed to maximum, 0.2 m/s');
    roombaSpeed = .2;
end

if (turnAngle < 0 ) % Makes sure the robot turns in the right direction
    turnDir = -eps;
else
    turnDir = eps;
end

if turnAngle ~=0
    roombaSetFwdVelRadius(roombaSpeed, turnDir);
    roombaSendMessage([sprintf('\x9D') IntToHex(turnAngle)])
    roombaSetFwdVelRadius(0, 0);
end
