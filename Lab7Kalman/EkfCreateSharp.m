% Filtre Kalman etendu EKF
% Pour un robot Create et un capteur infrarouge Sharp 2Y0A02
% (c) 2010-2012 Philippe Giguere

clearvars
clf
myFontSize = 14;
dT = 1;     % Intervalle des mesures

% Variables inconnues d�crivant le syst�me.
SVSharp  = 0.02;   % (V) ecart-type sur voltage du capteur infrarouge
SCreate  = 0.002;  % (m) ecart-type sur un pas du create
xVrai    = 0.30;   % Position de depart du robot, par rapport au mur

% Variables connues
Cv = SCreate^2; % Variance du bruit de deplacement
Cw = SVSharp.^2;  % Variance du bruit de mesure

% Actions du systeme 
u = 0.05; % (m) Longeur d'un pas du robot

% Initialiser le filtre
P = Cv;
K = NaN;
clf

% Aller chercher les parametres K1Sharp K2Sharp de la calibration
if (~exist('CalibSharp.mat','file'))
    display('Vous devez calibrer votre capteur infrarouge avant ce script!');
    return
end
load CalibSharp.mat

Data = csvread('calibration.csv');
Xcal = Data(:,1)*0.01; % Convertir en metre
Zcal = Data(:,2);

if (0)
    Xcal = fliplr(Xcal')';
    Zcal = fliplr(Zcal')';
    u = -u;
end

CasSimule = false;

% Parametre de la simulation
if (CasSimule)
    nStep = 20;
else
    nStep = size(Data,1);
end
Ax = zeros(1,nStep);
ASharp = zeros(1,nStep);
AError = zeros(1,nStep);
ATime = zeros(1,nStep);
AP = zeros(1,nStep);
AK = zeros(1,nStep);
Az = zeros(1,nStep);

for iStep = 1:nStep
    % Simulation du systeme
    time = iStep*dT;
    
    SkipFilter = false;
    
    if (CasSimule)
        % Je simule la reponse bruitee du capteur de distance infrarouge Sharp
        X = xVrai;
        xVrai = xVrai + u + SCreate*randn;
        z = K1Sharp + K2Sharp./xVrai + SVSharp*randn;
    else
        if (iStep == 1)
            if (1)
                % Cas 2
                % Je dois initialiser un pas en arriere, a partir mesure
                X = K2Sharp./(Zcal(1)-K1Sharp);
                H = [-K2Sharp/(X^2)]; % Je dois utiliser mon estime pour ici, car je ne connais pas la vraie valeur
                P = inv(H)*Cw*inv(H');  % Pour donner la covariance de la mesure
                SkipFilter = true;
            else
                % Cas 1
                X = Xcal(1)-u;
                P = 0;
            end
        end
        % Je prends les vraies donnees
        xVrai = Xcal(iStep);
        z = Zcal(iStep);
    end
    
    
    if (~SkipFilter)   
        % ========= Calcul des matrices Jacobiennes pour propagation =============
        F = [1]; % Phi, pour dynamique systeme
        G = [1]; % Gamma, pour matrice de commande

        % Propagation de l'estime. Normalement une fonction lineaire, mais ici
        % c'est lineaire.
        X = F*X + G*u;
        P = F*P*F' + G*Cv*G';  % Propagation covariance

        % ========= Calcul des matrices Jacobiennes pour mise-a-jour =============
        H = [-K2Sharp/(X^2)]; % Je dois utiliser mon estime pour ici, car je ne connais pas la vraie valeur

        zhat =  K1Sharp + K2Sharp./X;

        % ======== Mise-a-jour ========
        K = P*H'/(H*P*H'+Cw);   % Gain Kalman
        r = (z-zhat);           % Innovation
        X = X + K*r;
        P = (eye(size(P))-K*H)*P;
    end
    
    % Cueillette des donnees pour les graphiques
    Ax(iStep)           = xVrai;
    AEx(iStep)          = X;
    Az(iStep)           = z;
    AK(iStep)           = K;
    AP(iStep)           = P;
    AError(iStep)       = xVrai-X;
    ATime(iStep) = time;
end

figure(1);
clf
subplot(2,4,[1 2 3]);
h(1) = plot(ATime,Ax,'k.','LineWidth',3);
hold on
h(2) = plot(ATime,AEx,'go');
% On va inverser la fonction de capteur, pour trouver la position estimee
% par le capteur infrarouge
XSharpEst = K2Sharp./(Az-K1Sharp);
h(3) = plot(ATime,XSharpEst,'r*');
xlabel('Temps (s)','FontSize',myFontSize);
ylabel('Position (m)','FontSize',myFontSize);
set(gca,'FontSize',myFontSize-2);
legend(h,{'Position veritable' 'Filtre Kalman' 'Capteur infrarouge seulement'},'Location','NorthWest');

subplot(6,4,[1 2 3]+3*4);
plot(ATime,AError,'k-','LineWidth',2);
ylabel('Erreur');

subplot(6,4,[1 2 3]+4*4);
plot(ATime,AP,'k-','LineWidth',2);
ylabel('Covariance P');

subplot(6,4,[1 2 3]+5*4);
plot(ATime,AK,'k-','LineWidth',2);
ylabel('Gain K');

subplot(4,4,4);
ASharpError = Ax-XSharpEst;
hist(ASharpError);
c = axis();
title(sprintf('Ecart-type infrarouge=%.2f mm',std(ASharpError)*1000));
xlabel('Erreur (m)');

subplot(4,4,8);
hist(AError);
xlim(c(1:2));
title(sprintf('Ecart-type Kalman=%.2f mm',std(AError*1000)));
xlabel('Erreur (m)');




