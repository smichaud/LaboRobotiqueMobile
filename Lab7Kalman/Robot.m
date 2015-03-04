clearvars

% emplacement des toolbox
addpath('../../Software/Workstation/RoombaControl')
addpath('../../Software/Workstation/ros4mat/wrapper')

% parametres du robot
IP = '10.240.213.48';
adc_freq = 100;
adc_channels = 1;  % abonnement au IR longue portee (canal 1 = valeur 1)
polling_freq = 10;
buffer_length = 0.5; % en secondes

% connexion au robot
ros4mat('connect', IP, 1);
ros4mat('subscribe','adc', adc_freq, adc_channels, buffer_length * adc_freq, polling_freq);
roombaInit
pause(1)

% parametres de déplacement
longueurPas = 0.05;    % en metres
vitesse = 0.05;        % en metres/s
positionDepart = 0.3;  % en metres
positionFinale = 1.4;  % en metres
nbPas = (positionFinale-positionDepart)/longueurPas + 1;

figure(1)
positions = zeros(nbPas,1);
mesures = zeros(nbPas,1);
h = plot(positions, mesures, 'b', 'Marker', 'o');
axis([positionDepart positionFinale 0 2.5])
xlabel('Position [m]')
ylabel('Sortie du capteur [V]')

for i = 1:nbPas+1
    % recuperation des donnees du capteur
    [adc, ~] = ros4mat('adc');
    donneesIR = adc(1,:);
    
    % nouvelle mesure
    positions(i) = positionDepart + (i-1)*longueurPas;
    mesures(i) = donneesIR(end);
    
    % mise a jour du graphique avec la nouvelle mesure
    set(h, 'XData', positions(positions ~= 0), 'YData', mesures(mesures ~= 0))
    drawnow
    
    if i < nbPas+1
        roombaTravelDist(vitesse, -longueurPas)
    end
    
    % laisse le temps au robot de se deplacer et au buffer de donnees de se
    % remplir par la suite
    pause(4)

end

% sauvegarde les donnees
csvwrite('donneesRobot.csv', [100*positions, mesures])







