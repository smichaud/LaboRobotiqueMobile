warning('N''oubliez-pas de faire ros4mat(''connect'',''votre IP'',1)');

% Code pour l'acquisiton des donnes des deux gyroscopes
sensorsFlag = 240; % (1)IR_20_150 (2)IR_10_80 (16)GyroZ (32)Gyro4Z (64)GyroX (128)Gyro4X
acquisitionFrequency = 140; % Hz (max.2000-10000HZ, IR=25Hz, Gyro=140Hz)
pollingFrequency = 15; % Taux de remplissage du buffer circulaire 
bufferDuration = 1; % seconds
bufferSize = acquisitionFrequency*bufferDuration;

ros4mat('subscribe','adc', acquisitionFrequency, sensorsFlag, bufferSize, pollingFrequency);
pause(bufferDuration + 0.8);

firstTimestamp = 0;
allTimestamps = [];
allData = [];

while(1)
    [data, timestamps] = ros4mat('adc');
    
    % Pour avoir le temps a partir du debut de l'acquisition
    if (firstTimestamp ==0)
        firstTimestamp = min(timestamps);
    end
    timestamps = timestamps - firstTimestamp;
    
    % Pour fixer un bug dans ros4mat qui elimine les donnees lors de la
    % lecture
    allTimestamps = [allTimestamps timestamps];
    allData = cat(2,allData,data);
    
    if (size(allTimestamps,2) > bufferSize)
        allTimestamps = allTimestamps(end-bufferSize:end);
        allData = allData(:,end-bufferSize:end);
    end
    
    subplot(2,1,1)
    plot(allTimestamps, allData(5,:)); %GyroZ
    ylim([0,3]);
    xlabel('Temps (s)');
    ylabel('Voltage Gyro Z 1X');
    
    subplot(2,1,2)
    plot(allTimestamps, allData(6,:)); %Gyro4Z
    ylim([0,3]);
    xlabel('Temps (s)');
    ylabel('Voltage Gyro Z 4X');
   
    pause(0.2); 
end

ros4mat('unsubscribe', 'adc');
