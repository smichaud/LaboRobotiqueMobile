% Script de test pour le laboratoire 1
% Utiliser F1 sur une fonction pour plus d'info !

% Structure : 
% ros4mat('subscribe','Capteur',FreqAcquisition,ExtraInfo,TailleBuffer,FreqPolling,ExtraInfo2)
% [donnees, timestamps] = ros4mat('Capteur');
% ros4mat('unsubscribe', 'Capteur')
% Capteurs : 'camera', 'adc', ou'hokuyo'.

clc
clearvars

addpath('../RoombaControl')
addpath('../ros4mat/matlab')

IP = '192.168.1.175';
ros4mat('connect', IP, 1);
%--------------------------------------------------------------------------

% Test Roomba
roombaInit
roombaBeep
roombaSetLEDs(0,150,150)
roombaSetFwdVelRadius(0.025, 2.0)
roombaTravelDist(0.025, 0.1)
roombaTurnAngle(0.1,45)

% Test ADC
ros4mat('subscribe', 'adc', 140, 1, 500, 10);
pause(3); % Donne le temps au buffer de se remplir
[donnees, timestamps] = ros4mat('adc');
ros4mat('unsubscribe', 'adc');

% Test ADC en continue
ros4mat('subscribe', 'adc', 140, 32, 500, 10) % 500/100Hz = 5 secondes
while true
[donnees, timestamps] = ros4mat('adc')
pause(1)
end
ros4mat('unsubscribe', 'adc')


% Test camera photo x1
cameraID = 1;
ros4mat('subscribe', 'camera', 5, '640x480', cameraID, 5, 1);
pause(5); %while isempty(image) end
[image, timestamp] = ros4mat('camera');
imshow(image(:,:,:,1))% 3 premieres dimensions = RGB. La 4e =indice de l'image.
ros4mat('unsubscribe', 'camera') % Optionnel

% Test camera en continue
cameraID = 1;
ros4mat('subscribe', 'camera', 30, '640x480', cameraID, 30, 1);
pause(0.5); % Donne le temps � la cam�ra de prendre une image
figure(1)
while true
    [image, timestamp] = ros4mat('camera');
    if ~isempty(image) % si l'image est vide, c'est parce que la camera n'a
        % pas eu le temps de prendre une nouvelle image
        % depuis la derni�re boucle. Dans ce cas on passe.
        imshow(image(:,:,:,1))
        hold on;
        drawnow
    end
end
ros4mat('unsubscribe', 'camera')

% Test Hokuyo
ros4mat('subscribe', 'hokuyo', 10);
pause(0.5);
[donnees, timestamps] = ros4mat('hokuyo');
ros4mat('unsubscribe', 'hokuyo')

% Test Kinect
sensor = 'kinect';
captureFrequency = 10;
resolution = '640x480';
bufferSize = 1;
pollingFrequency = 10;
ros4mat('subscribe', sensor, captureFrequency, resolution, bufferSize, pollingFrequency);

image = [];
depthMap = [];
while isempty(image) || isempty(depthMap)
    [image, depthMap, timestamp] = ros4mat(sensor);
end
rgbImage = flipdim(image,3);
subplot(1,2,1);
imagesc(rgbImage);
daspect([1 1 1]);
subplot(1,2,2);
imshow(depthMap);
daspect([1 1 1]);
ros4mat('unsubscribe', sensor)


% Test random
adc_freq = 1000;
adc_channels = 1;  % abonnement au IR longue portee (canal 1 = valeur 1)
polling_freq = 5;
buffer_length = 1; % en secondes
ros4mat('subscribe','adc', adc_freq, adc_channels, buffer_length * adc_freq, polling_freq);
pause(1)
[donnees, timestamps] = ros4mat('adc');
firstTimestamp = timestamps(1);
% loopStopper = 0;
Total = 0; bad = 0;
while true
    [donnees, timestamps] = ros4mat('adc');
    %distances = irOutput2Distance('long', donnees(1,:), true)
    plot(timestamps-firstTimestamp, donnees)
%     loopStopper = timestamps(end)-firstTimestamp;
    ylim([0 5])
    if (isempty(distances))
        bad = bad+1;
    end
    Total = Total +1;
    title(sprintf('bad=%d/%d',bad,Total));
    drawnow; %pause(0.05);
end
ros4mat('unsubscribe', 'adc')
%--------------------------------------------------------------------------
ros4mat('close')