clearvars
clearvars -global

% emplacement des toolbox
addpath('../../RoombaControl')
addpath('../../ros4mat/matlab')

% parametres du robot
IP = '10.248.220.255';
hokuyo_freq = 10;  % frequence max. du Hokuyo = 10 Hz
polling_freq = 10;

% connexion au robot
ros4mat('connect',IP,1);
ros4mat('subscribe','hokuyo', hokuyo_freq, 0, 1, polling_freq);
roombaInit
pause(1)

% variables globales
global VITESSE_ROBOT; VITESSE_ROBOT = 0.2;
global LONGUEUR_PAS_ROBOT; LONGUEUR_PAS_ROBOT = 0.3;
global ANGLE_VIRAGE_ROBOT; ANGLE_VIRAGE_ROBOT = 45;
global HOKUYO_RANGE_MIN; HOKUYO_RANGE_MIN = 0.15;
global HOKUYO_RANGE_MAX; HOKUYO_RANGE_MAX = 5.3;
global colors; colors = ['b' 'r' 'm' 'k' 'g' 'y'];


% demarre l'interface
global hGUI
hGUI = gui;

resetAll()

