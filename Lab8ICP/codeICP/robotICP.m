global robotCommandeRot
global robotCommandeTransl
global Cum
global CumICP
global NewScan
global ScanPrec
global ScanPrecICP
global ScanLocalPrec
global AlignementApproxICP
global hGUI
global colors
global scanNum
global hPosRobot
global hRotRobot

% couleur du prochain scan sur les cartes
scanNum = scanNum + 1;
col = colors(mod(scanNum,length(colors))+1);

% handles vers les systemes d'axes
hAxes1 = findobj(hGUI, 'Tag', 'axes1');
hAxes2 = findobj(hGUI, 'Tag', 'axes2');
hAxes3 = findobj(hGUI, 'Tag', 'axes3');
hAxes4 = findobj(hGUI, 'Tag', 'axes4');


% approximation de R et T a partir des commandes envouees au robot
if AlignementApproxICP
    Urot = robotCommandeRot;
    Ux = robotCommandeTransl(1);
    Uy = robotCommandeTransl(2);
else
    Urot = 0;
    Ux = 0;
    Uy = 0;
end

robotCommandeRot = 0;
robotCommandeTransl = [0 0];

% Rotation et translation approx. selon les commandes
R = [cosd(Urot) -sind(Urot) 0; sind(Urot) cosd(Urot) 0; 0 0 1];
T = [ 1  0 Ux; 0 1 Uy; 0 0 1];
Cum = Cum*R*T;
CumICP = CumICP*R*T;


% Transferer les points dans coordonnes du premier
for index = 1:size(NewScan,2)
    NewScanLocal(:,index) = Cum*[NewScan(1,index) NewScan(2,index) 1]';
end

% Transferer les points dans coordonnes du premier (ICP)
for index = 1:size(NewScan,2)
    NewScanICP(:,index) = CumICP*[NewScan(1,index) NewScan(2,index) 1]';
end


% Affiche le nouveau scan REPERE LOCAL
axes(hAxes1)
cla(hAxes1)
hold(hAxes1, 'on')
p11 = plot(NewScan(1,:), NewScan(2,:), 'bx');
axis(hAxes1, 'equal')
legend(p11, 'Nouveau scan')
title('Scans dans repere local')

% Affiche le nouveau scan sur la CARTE SANS ICP
axes(hAxes2)
hold(hAxes2, 'on')
p21 = plot(NewScanLocal(1,:), NewScanLocal(2,:), 'x', 'color', col);
axis(hAxes2, 'equal')
legend(p21, 'Nouveau scan')
title('Carte sans ICP')

% Affiche le nouveau scan sur le GRAPHIQUE ICP
axes(hAxes3)
cla(hAxes3)
hold(hAxes3, 'on')
p31 = plot(NewScanICP(1,:), NewScanICP(2,:), 'bx');
axis(hAxes3, 'equal')
legend(p31, 'Nouveau scan')


% Pour le premier scan
if isempty(ScanPrecICP)
    % Affiche le scan sur la CARTE AVEC ICP
    axes(hAxes4)
    hold(hAxes4, 'on')
    p41 = plot(NewScanICP(1,:), NewScanICP(2,:), 'x', 'color', col);
    axis(hAxes4, 'equal')
    legend(p41, 'Nouveau scan aligne')
    title('Carte de l''environnement avec ICP')
    % affiche la position du robot
    posRobot = CumICP * [0 0 1]';
    devantRobot = CumICP * [0.2 0 1]';
    hPosRobot = plot(posRobot(1), posRobot(2), 'ko', 'MarkerSize', 5, 'LineWidth', 2);
    hRotRobot = line([posRobot(1) devantRobot(1)], [posRobot(2) devantRobot(2)], 'MarkerSize', 5, 'LineWidth', 2);

    ScanPrecICP = NewScanICP;
    ScanPrec = NewScan;
    ScanLocalPrec = NewScanLocal;
    return
end


% Affiche le scan precedent REPERE LOCAL
axes(hAxes1)
hold(hAxes1, 'on')
p12 = plot(ScanPrec(1,:), ScanPrec(2,:), 'rs');
axis(hAxes1, 'equal')
legend([p11 p12], 'Nouveau scan', 'Scan precedent')
title('Scans dans repere local')

% Affiche le scan precedent sur le GRAPHIQUE ICP
axes(hAxes3)
p32 = plot(ScanPrecICP(1,:), ScanPrecICP(2,:), 'rs');
axis(hAxes3, 'equal')
legend([p31 p32], 'Nouveau scan', 'Scan precedent')
title('Scans ICP')


% Force l'affichage immediat des graphiques
drawnow


% =================== AJUSTEMENT ICP =======================
% Le zero a la fin est important sinon le match de scan commence par 
% centrer la moyenne des points, ce qui n'est pas bon du tout!
[RICP TICP] = icp(ScanPrecICP(1:2,:),NewScanICP(1:2,:),300,30,[3 0.55],1e-5,0);

RH = [RICP(1,1) RICP(1,2) 0; RICP(2,1) RICP(2,2) 0; 0 0 1];
TH = [1 0 TICP(1); 0 1 TICP(2); 0 0 1];

% Transforme les points du nouveau scan selon le resultat d'ICP
for index=1:size(NewScanICP,2)
    ShiftedData(:,index) = RICP*NewScanICP(1:2,index)+TICP;
end

% Affiche le scan aligne sur le GRAPHIQUE ICP
p33 = plot(ShiftedData(1,:),ShiftedData(2,:),'go');
axis(hAxes3, 'equal')
legend([p31 p32 p33], 'Nouveau scan', 'Scan precedent', 'Nouveau scan aligne')


% Ajuster la matrice de deplacement
CumICP = TH*RH*CumICP;

% Transferer les points dans coordonnes du premier, apres ICP
for index = 1:size(NewScan,2)
    NewScanICP(:,index) = CumICP*[NewScan(1,index) NewScan(2,index) 1]';
end

% Affiche le nouveau scan aligne sur la CARTE AVEC ICP
axes(hAxes4)
hold(hAxes4, 'on')
p41 = plot(NewScanICP(1,:), NewScanICP(2,:), 'x', 'color', col);
axis(hAxes4, 'equal')
legend(p41, 'Nouveau scan aligne')
title('Carte de l''environnement avec ICP')
% affiche la position du robot
posRobot = CumICP * [0 0 1]';
devantRobot = CumICP * [0.2 0 1]';
set(hPosRobot, 'XData', posRobot(1), 'YData', posRobot(2))
set(hRotRobot, 'XData', [posRobot(1) devantRobot(1)], 'YData', [posRobot(2) devantRobot(2)])


% Accumuler scan precedent
ScanPrecICP = NewScanICP;
ScanPrec = NewScan;
