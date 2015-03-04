clf;

% parametres
f = ; % distance focale de votre camera

% Points de reperes, tels qu'apparaissant DE GAUCHE A DROITE DANS L'IMAGE
p1 =[-1 1]';
p2 = [0 0]';
p3 = [1 0]';

% On prend une image et on l'affiche
image = ros4mat('camera');
LastImage = image(:,:,:,end); % Car c'est une matrice d'image que ros4mat retourne
imagesc(LastImage);

u0 = 0.5*size(LastImage,2); % Centre de l'image, coordonne X. Les dimensions x-y d'une image sont interverties.

title('Cliquez sur les trois reperes, dans l''ordre p1 a p3');
[Lx Ly] = ginput(3);

% Calcul des angles
theta = atan((Lx-u0)/f);
alpha = theta(2) - theta(1);
beta  = theta(3) - theta(2);

% Calcul du centre des cercles et rayons
c1 = [0 -1; 1 0]*(p1-p2)./(2*tan(alpha))+ 0.5*(p2+p1);
c2 = [0 -1; 1 0]*(p2-p3)./(2*tan(beta))+ 0.5*(p3+p2);

r1 = sqrt(sum((p1-p2).^2)) / (2*sin(alpha));
r2 = sqrt(sum((p2-p3).^2)) / (2*sin(beta));

clf
plot(p1(1),p1(2),'bo','MarkerFace','b'); text(p1(1)+0.12,p1(2)+0.12,'p1');
hold on;
plot(p2(1),p2(2),'ro','MarkerFace','r'); text(p2(1)+0.12,p2(2)+0.12,'p2');
plot(p3(1),p3(2),'go','MarkerFace','g'); text(p3(1)+0.12,p3(2)+0.12,'p3');

circle(c1,r1,1000,'r');
circle(c2,r2,1000,'g');

title('Le robot se situe a l''intersection des deux cercles','FontSize',15);
grid on;

% Pour avoir un grid sur les coins de tuiles
xTick = get(gca,'XTick');
xTick = min(xTick):1:max(xTick);
set(gca,'XTick',xTick);
yTick = get(gca,'YTick');
yTick = min(yTick):1:max(yTick);
set(gca,'YTick',yTick);
xlabel('x','FontSize',13);
ylabel('y','FontSize',13);
axis equal;
hold off;

