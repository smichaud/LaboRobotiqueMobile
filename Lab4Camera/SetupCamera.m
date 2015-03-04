clear all;
addpath('../ros4mat/matlab')
IP = '10.248.115.19';  % Mettre l'adresse IP du robot format xxx.xxx.xxx.xxx
ros4mat('connect', IP, 1);

CameraID = 1; % Normalement 0, mais si vous avez une camera sur votre laptop, vous devrez peut-etre mettre cette valeur a 1
Exposure = 300; % Plus c'est bas, plus l'image est lumineuse.
JpegQuality = 90;
Frequency = 2;
PollingFrequency = Frequency;
BufferSize = 2;
ros4mat('subscribe','camera', Frequency, '640x480', BufferSize, PollingFrequency, CameraID, JpegQuality, Exposure)

pause(1);
% Je jette les premieres image, juste au cas qu'elles soient vides
for index = 1:10
    display(sprintf('Test image %d',index));
    image = ros4mat('camera');
    if (size(image,1)~=0)
        break;
    end
    pause(1);
end
