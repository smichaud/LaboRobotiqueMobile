% Fonction de calibration du capteur Sharp
% (c) 2012 Philippe Giguere et Maxime Latulippe

clearvars
clf

% Charger les donnees pour la calibration
Data = csvread('calibration.csv');
Xcal = Data(:,1)*0.01; % Convertir en metre
Zcal = Data(:,2);
invXcal = 1./Xcal;
h(1) = plot(invXcal,Zcal,'o');
hold on;
p = polyfit(invXcal,Zcal,1);
K1Sharp = p(2);
K2Sharp = p(1);
Zest = K1Sharp + K2Sharp./Xcal;
h(2) = plot(1./Xcal,Zest,'r+');
legend(h,{'Donnes' 'Modele calibre'},'Location','NorthWest');

save CalibSharp.mat K1Sharp K2Sharp