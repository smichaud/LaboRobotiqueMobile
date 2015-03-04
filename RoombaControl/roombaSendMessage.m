function roombaSendMessage(message)

global roombaSerPortName
global roombaBaudRate
global roombaDelaySec
global roombaDelayUSec

ros4mat('serie', roombaSerPortName, roombaBaudRate, 0, 1, message, length(message), 0, roombaDelaySec, roombaDelayUSec, 0);
pause(0.02)

end