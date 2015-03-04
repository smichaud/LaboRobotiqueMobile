sensor = 'kinect';
captureFrequency = 10;
resolution = '640x480';
bufferSize = 1;
pollingFrequency = 10;

ros4mat('subscribe', sensor, captureFrequency, resolution, bufferSize, pollingFrequency);