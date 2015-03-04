function roombaSetLEDs(LED, Color, Intensity)
% roombaSetLEDs(LED, Color, Intensity)
% Manipulates LEDS
% LED = 0;both off LED=1;Play on LED=2;Advance on LED=3;Both on 
% Color determines which color(Red/Green) that the Power LED will
% illuminate
% 0 = green, 255 = red. Intermediate values are intermediate
% colors (orange, yellow, etc).
% Intensity determines how bright the Power LED appears from 0-255

% By; Joel Esposito, US Naval Academy, 2011
% Modified by: Maxime Latulippe, Laval University, 2012


if(LED==0)
    LED=bin2dec('00000000');
end
if(LED==2)
    LED=bin2dec('00001000');
end
if(LED==1)
    LED=bin2dec('00000010');
end

if (LED==3)
    LED=bin2dec('00001010');  
end
   
L= LED;

roombaSendMessage([sprintf('\x8B') L IntToHex(Color) IntToHex(Intensity)])

