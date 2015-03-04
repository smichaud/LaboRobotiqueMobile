clf; % Pour effacer la figure

sensorsFlag = 240; % (1)IR_20_150 (2)IR_10_80 (16)GyroZ (32)Gyro4Z (64)GyroX (128)Gyro4X
acquisitionFrequency = 140; % Hz (max.2000-10000HZ, IR=25Hz, Gyro=140Hz)
pollingFrequency = 15; % Hz 
bufferDuration = 1; % seconds
bufferSize = acquisitionFrequency*bufferDuration;

ros4mat('subscribe','adc', acquisitionFrequency, sensorsFlag, bufferSize, pollingFrequency);
buffer = [];
timeAcquired = 0;
timeDesired = 30; % duree de l'acquisition
while(timeAcquired < timeDesired)
    [data, timestamps] = ros4mat('adc');
    usedData = [timestamps;data(5,:)];
    buffer = [buffer usedData]; % concatenate last data with the new data
    if(~isempty(buffer))
       timeAcquired = buffer(1,end) - buffer(1,1);
    end
    
    plot(buffer(1,:)-buffer(1,1), buffer(2,:)); %GyroZ
    ylim([0,3]);
    xlabel('Temps (s)');
    ylabel('Voltage Gyro Z 1X');
    pause(0.5);
end
result = unique(buffer', 'rows');

% The first row is the [0, 120], the second row is the gyroZ value
adjustedResult = [result(:,1)-result(1,1) result(:,2)]

ros4mat('unsubscribe', 'adc')

