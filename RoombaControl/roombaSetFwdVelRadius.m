function roombaSetFwdVelRadius(FwdVel, Radius);
% roombaSetFwdVelRadius(FwdVel, Radius)

%  Moves Roomba by setting forward vel and turn radius
%  serPort is a serial port object created by Roombainit
%  FwdVel is forward vel in m/sec [-0.5, 0.5],
%  Radius in meters, postive turns left, negative turns right [-2,2].
%  Special cases: Straight = inf
%  Turn in place clockwise = -eps
%  Turn in place counter-clockwise = eps

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Maxime Latulippe, Laval University, 2012


%% Convert to millimeters
FwdVelMM = min( max(FwdVel,-.5), .5)*1000;

if isinf(Radius)
    RadiusMM = 32768;
elseif Radius == eps
    RadiusMM = 1;
elseif Radius == -eps
    RadiusMM = -1;
else
    RadiusMM = min( max(Radius*1000,-2000), 2000);
end

roombaSendMessage([sprintf('\x89') IntToHex(FwdVelMM) IntToHex(RadiusMM)]);
