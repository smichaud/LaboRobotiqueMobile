clearvars
clf

Data = csvread('EstimeBruit2.csv');
Xcal = Data(:,1)*0.01; % Convertir en metre
Zcal = Data(:,2);

load CalibSharp.mat

XSharpEst = K2Sharp./(Zcal-K1Sharp);
plot(XSharpEst,'r*');
hold on
plot(Xcal,'k.');

hist((XSharpEst-Xcal)*1000)

std((XSharpEst-Xcal)*1000)

% Estimation du bruit
H = [-K2Sharp/(mean(Xcal)^2)];
SVSharp  = 0.02; 

abs(H*SVSharp*0.5) % Une demi palier
