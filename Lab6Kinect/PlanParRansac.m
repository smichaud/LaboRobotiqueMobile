% PlanParRansac(DepthData, nTrial, epsilon)
% Effectue un RANSAC assez simple pour trouver des plans dans un nuage
% de point. Ce code est incomplet, dans la mesure ou il ne vous
% retourne rien, mais simplement execute l'algorithme RANSAC. A vous de
% le modifier pour retourner quelque chose.
% En entree :
%    DepthData : matrice de AxBx3 contenant le nuage de points
%    nTrial    : nombre d'iteration RANSAC
%    epsilon   : tolerance sur la distance point-plan 
%
% Lors de l'affichage, les points en rouge sont les points consideres comme
% des inliers.
%
% Aussi, vous pouvez accelerer le traitement en :
%  - decimant le nombre de point (voir FacteurReduction plus bas);
%  - enlevant l'affichage des points a l'ecran;
%  - en ne conservant que les points dans la partie inferieure du
%    nuage, proche du plancher.
% 
% Cours GLO-4001/GLO-7021
% (c) 2013 Philippe Giguere, U. Laval
% 

function PlanParRansac(DepthData, nTrial, epsilon)  
    % Je transforme la matrice en une matrice de dimension a x b x 3 en une
    % nouvelle matrice de taille Nx3. Cela permet de faire du calcul
    % matriciel plus bas  pour le calcul des distances (au lieu de boucles
    % for qui sont lentes en matlab)
    [a b c] = size(DepthData);
    VectorDepth = reshape(DepthData,[a*b c]);

    % J'enleve tous les NaN indiquant des profondeurs invalides
    Index = find(~isnan(VectorDepth(:,1)));
    VectorDepth = VectorDepth(Index,:);

    % Nombre de points dans le nuage de points
    N = size(VectorDepth,1);

    if (0)
        % Activez ces lignes si vous voulez decimer le nombre de points,
        % pour accelerer le calcul. Tres important si vous voulez
        % fonctionner en temps quasi-reel.
        FacteurReduction = 10;
        VectorDepth = VectorDepth(1:FacteurReduction:N,:);
        N = size(VectorDepth,1);
    end

    for iTrial=1:nTrial
        % On pige trois points au hasard.
        Index = ceil(rand(3,1)*N);

        % On calcule la normale de ce plan avec le produit croise.
        x1 = VectorDepth(Index(1),:);
        x2 = VectorDepth(Index(2),:);
        x3 = VectorDepth(Index(3),:);
        Normal = cross((x2-x1),(x3-x1));
        Normal = Normal./norm(Normal);

        % Facon rapide de calculer le produit scalaire entre une matrice
        % comprenant tous les points et un vecteur x1, et calculer la distance 
        % entre un point et un plan. Ce code est beaucoup
        % plus rapide que de faire une boucle for index=1:N pour calculer
        % ces valeurs individuellement. 
        % Ici j'ai choisi x1, mais x2 ou x3 aurait aussi bien fait
        % l'affaire.
        tmp = ones(N,1)*x1; % cree une matrice Nx3 matrix qui est une repetition de x1
        dp = (VectorDepth-tmp)*Normal'; % Calcul optimise format matlab pour calcul des distances.
        
        % Partons a la recherche des inliers
        inliers = find(abs(dp)<epsilon); % Facon rapide matlab de trouver elements de matrice qui satisfasse une condition
        nInliers = size(inliers,1);

        if (1)
            % Pour voir l'affichage de l'execution de l'algorithme.
            plot3(VectorDepth(:,1),VectorDepth(:,2),VectorDepth(:,3),'k.','MarkerSize',1);
            axis equal
            hold on;
            plot3(VectorDepth(inliers,1),VectorDepth(inliers,2),VectorDepth(inliers,3),'r.','MarkerSize',2);
            hold off;
            title(sprintf('Nombre d inliners = %d',nInliers));
            display(sprintf('Nombre d inliners = %d',nInliers));
            drawnow; % Force le rafraichissement de la fenetre. Autrement vous n'allez rien voir.
        end
    end
end
