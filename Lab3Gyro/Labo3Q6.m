clf; % Pour effacer la figure

% Parametre du gyroscope
BiaisZero = ;%  Mettez vos valeurs a vous!
Gain = ; % en o/sV

sensorsFlag = % 243; % (1)IR_20_150 (2)IR_10_80 (16)GyroZ (32)Gyro4Z (64)GyroX (128)Gyro4X
acquisitionFrequency = 140; % Hz (max.2000-10000HZ, IR=25Hz, Gyro=140Hz)
pollingFrequency = 15; % Hz 
bufferDuration = 1; % seconds
bufferSize = acquisitionFrequency*bufferDuration;
ros4mat('subscribe','adc', acquisitionFrequency, sensorsFlag, bufferSize, pollingFrequency);

pause(2);

% Table de calibration du capteur infrarouge longue portee, pour 15+ cm
CalibTableLong       = [15 2.76;
                        20 2.53;
                        30 1.99;
                        40 1.53;
                        50 1.23;
                        60 1.04;
                        70 0.91;
                        80 0.82;
                        90 0.72;
                        100 0.66;
                        110 0.6;
                        120 0.55;
                        130 0.50;
                        140 0.46;
                        150 0.435;
                        150 0];

buffer = [];
timeAcquired = 0;
timeDesired = 30; % duree de l'acquisition
while(1)
    [data, timestamps] = ros4mat('adc');
    usedData = [timestamps;data([2,5],:)];
    buffer = [buffer usedData]; % concatenate last data with the new data
    if(~isempty(buffer))
       timeAcquired = buffer(1,end) - buffer(1,1);
    end
    
    subplot(2,3,1);
    plot(buffer(1,:)-buffer(1,1), buffer(2,:)); % Infrarouge
    ylim([0,3]);
    xlabel('Temps (s)');
    ylabel('Voltage Infrarouge');
    result = unique(buffer', 'rows');
    
    subplot(2,3,4);
    plot(buffer(1,:)-buffer(1,1), buffer(3,:)); %GyroZ
    ylim([0,3]);
    xlabel('Temps (s)');
    ylabel('Voltage Gyro Z 1X');
    result = unique(buffer', 'rows');

    % Faire la carte en coordonnee polaire
    Angle = 0.0175*Gain*cumsum(buffer(3,:)-BiaisZero)/140; % pour avoir des degres
    
    % On va juste prendre un point sur 4
    SubIndex = 1:4:size(Angle,2);
    Dist  = interp1(CalibTableLong(:,2),CalibTableLong(:,1),buffer(2,SubIndex)) + 15;
    subplot(2,3,[2 3 5 6]);
    polar(Angle(SubIndex),Dist,'r.');
    title('Carte en coordonnees polaires');
    pause(0.25);
end

ros4mat('unsubscribe', 'adc')

