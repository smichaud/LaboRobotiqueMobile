function message = roombaReceiveMessage(len)

global roombaSerPortName
global roombaBaudRate
global roombaDelaySec
global roombaDelayUSec

message = ros4mat('serie', roombaSerPortName, roombaBaudRate, 0, 1, [], 0, len, roombaDelaySec, roombaDelayUSec, 0);
pause(0.02)

end