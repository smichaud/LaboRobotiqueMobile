clc
clearvars

addpath('../RoombaControl')
addpath('../ros4mat/matlab')

IP = '10.240.209.2';
ros4mat('connect', IP, 1);

CalibTable           = [ 5 2.0;
                        10 2.5;
                        15 2.76;
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
                                  
                    
sensorsFlag = 1; % (1)IR_20_150 (2)IR_10_80 (16)GyroX (32)GyroZ (64)Gyro4X (128)Gyro4Z
acquisitionFrequency = 140; % Hz (max.2000-10000HZ, IR=25Hz, Gyro=140Hz)
pollingFrequency = acquisitionFrequency; % Hz 
bufferDuration = 0.5; % seconds
bufferSize = acquisitionFrequency*bufferDuration;
ros4mat('subscribe','adc', acquisitionFrequency, sensorsFlag, bufferSize, pollingFrequency)
for index=1:50
    pause(bufferDuration); % Let the sensor get all information
    [data, timestamps] = ros4mat('adc');
    zMean = mean(data(1,:));
    xProche = interp1(CalibTable(1:3,2),CalibTable(1:3,1),zMean);
    xLoin   = interp1(CalibTable(3:end,2),CalibTable(3:end,1),zMean);
    display(sprintf('Proche = %.2f cm  Loin = %.2f cm',xProche,xLoin));
    pause(0.2);
end
ros4mat('unsubscribe', 'adc')



%--------------------------------------------------------------------------
% ros4mat('close')
