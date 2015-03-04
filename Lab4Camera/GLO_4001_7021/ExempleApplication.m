clearvars;

addpath ../CalTag   % Ajouter le repertoire qui contient le code de CalTag

% Lire la photo contenant les tags
I = imread('Test2.JPG');

% detection des tags
Tags = caltag_glo4001_extraire(I, 'Patron1chiffre.mat', false );
 
clf
imagesc(I);
hold on;
for iFound=1:size(Tags,1);
        plot(Tags(iFound).corners(2,:),Tags(iFound).corners(1,:),'bo');
        text(mean(Tags(iFound).corners(2,:)),mean(Tags(iFound).corners(1,:)),sprintf('%d',Tags(iFound).id), ...
            'Color','r','FontSize',15,'BackgroundColor','w','FontWeight','bold','HorizontalAlignment','center');
        
end


