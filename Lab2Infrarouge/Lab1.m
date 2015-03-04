clc; clearvars;
addpath('../RoombaControl')
addpath('../ros4mat/matlab')
IP = '10.24';
ros4mat('connect', IP, 1);

if (Question == 1)
    % ------------------------------- 1 -------------------------------------- 
    sensorsFlag = 1; % (1)IR_20_150 (2)IR_10_80 (16)GyroX (32)GyroZ (64)Gyro4X (128)Gyro4Z
    acquisitionFrequency = 140; % Hz (max.2000-10000HZ, IR=25Hz, Gyro=140Hz)
    pollingFrequency = acquisitionFrequency; % Hz 
    bufferDuration = 1; % seconds
    bufferSize = acquisitionFrequency*bufferDuration;
    ros4mat('subscribe','adc', acquisitionFrequency, sensorsFlag, bufferSize, pollingFrequency)
    pause(bufferDuration + 0.8); % Let the sensor get all information
    [data, timestamps] = ros4mat('adc');
    meanValue = mean(data(1,:))
    ros4mat('unsubscribe', 'adc')
elseif (Question == 2)
    % ------------------------------- 2 -------------------------------------- 
    sensorsFlag = 1; % (1)IR_20_150 (2)IR_10_80 (16)GyroX (32)GyroZ (64)Gyro4X (128)Gyro4Z
    acquisitionFrequency = 140; % Hz (max.2000-10000HZ, IR=25Hz, Gyro=140Hz)
    pollingFrequency = acquisitionFrequency; % Hz 
    bufferDuration = 1; % seconds
    bufferSize = acquisitionFrequency*bufferDuration;
    ros4mat('subscribe','adc', acquisitionFrequency, sensorsFlag, bufferSize, pollingFrequency)
    while(1)
        pause(bufferDuration); % Let the sensor get all information
        [data, timestamps] = ros4mat('adc');
        numberOfValues = size(data(1,:))
        meanValue = mean(data(1,:))    
    end
    ros4mat('unsubscribe', 'adc')
elseif (Question == 4)
    % ------------------------------- 4 -------------------------------------- 
    sensorsFlag = 1; % (1)IR_20_150 (2)IR_10_80 (16)GyroX (32)GyroZ (64)Gyro4X (128)Gyro4Z
    acquisitionFrequency = 1000; % Hz (max.2000-10000HZ, IR=25Hz, Gyro=140Hz)
    pollingFrequency = acquisitionFrequency; % Hz 
    bufferDuration = 1; % seconds
    bufferSize = acquisitionFrequency*bufferDuration;

    ros4mat('subscribe','adc', acquisitionFrequency, sensorsFlag, bufferSize, pollingFrequency)
    pause(bufferDuration + 0.8); % Let the sensor get all information
    [data, timestamps] = ros4mat('adc');
    plot((timestamps(1,:)-timestamps(1,1))*1000, data(1,:))
    grid on
    ros4mat('unsubscribe', 'adc')
elseif (Question == 5)
    sensorsFlag = 1; % (1)IR_20_150 (2)IR_10_80 (16)GyroX (32)GyroZ (64)Gyro4X (128)Gyro4Z
    acquisitionFrequency = 20; % Hz (max.2000-10000HZ, IR=25Hz, Gyro=140Hz)
    pollingFrequency = acquisitionFrequency; % Hz 
    bufferDuration = 1; % seconds
    bufferSize = acquisitionFrequency*bufferDuration;

    ros4mat('subscribe','adc', acquisitionFrequency, sensorsFlag, bufferSize, pollingFrequency)
    pause(bufferDuration + 0.8); % Let the sensor get all information
    [data, timestamps] = ros4mat('adc');
    meanValue = mean(data(1,:))
    numberOfValues = size(data(1,:))
    ros4mat('unsubscribe', 'adc')
end

% --------------------------------------------------------------------------
ros4mat('close')
