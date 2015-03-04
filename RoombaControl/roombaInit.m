global roombaSerPortName
% roombaSerPortName = '/dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller_D-if00-port0';
roombaSerPortName = '/dev/ttyUSB0';

global roombaBaudRate
roombaBaudRate = 57600;

global roombaDelaySec
roombaDelaySec = 1;

global roombaDelayUSec
roombaDelayUSec = 100;


disp('Establishing connection to Roomba...');

% Start 128
roombaSendMessage(sprintf('\x80'))

% Full mode 132
roombaSendMessage(sprintf('\x84'))

% Power LED only 139 0 0 128
roombaSendMessage([sprintf('\x8B') 0 0 sprintf('\x80')])

roombaBeep

confirmation = roombaReceiveMessage(4)
