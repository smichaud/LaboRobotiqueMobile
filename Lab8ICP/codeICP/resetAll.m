clearvars


% Initialisation de ICP
global Cum; Cum = eye(3);
global CumICP; CumICP = Cum;
global AlignementApproxICP; AlignementApproxICP = true;

% Variables stockant le déplacement relatif au dernier scan
global robotCommandeRot; robotCommandeRot = 0;
global robotCommandeTransl; robotCommandeTransl = [0 0];


global NewScan; NewScan = [];
global ScanPrec; ScanPrec = [];
global NewScanICP; NewScanICP = [];
global ScanPrecICP; ScanPrecICP = [];
global scanNum; scanNum = 0;



global hGUI
for i = 1:4
    hAxes = findobj(hGUI, 'Tag', ['axes',num2str(i)]);
    cla(hAxes)
    axis(hAxes, 'normal')
end