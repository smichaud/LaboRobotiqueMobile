% Image of the Hokuyo box 6.8 cm wide with infrared
clf
x = [0 1 2 3 4 5 6 7 8 9 10 11 12 13];
z = [0.356 0.46 0.690 0.800 0.853 0.854 0.854 0.854 0.828 0.732 0.555 0.416 0.394 0.356];

% Shape of the box
bx = [-4       0  0.0001   6.8 6.8001 14]+2.3;
bz = [0.356 0.356 0.854  0.854  0.356 0.356];

clf
plot(x,z,'r-');
hold on;
h(1)=plot(x,z,'ro');
h(2)= plot(bx,bz,'b-','LineWidth',2);
legend(h,{'mesures','boite'});
xlabel('Position du capteur (cm)');
ylabel('Signal capteur (V)');

% Oversample the box

b2x = 0:0.01:13;
b2z = interp1(bx,bz,b2x);


xfilter = -3:0.01:3;
sfilter = 0.7;
BGauss = sqrt(exp(-(xfilter./sfilter).^2)./sqrt(2*pi*sfilter));
%b2zmodel = filter(BGauss,1,b2z);
%b2zmodel = conv(b2z,BGauss,'same');
%b2zmodel = b2zmodel.*(b2z(500)/b2zmodel(500))
%plot(b2x,b2zmodel,'g');