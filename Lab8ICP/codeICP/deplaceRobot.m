function deplaceRobot(button)

global VITESSE_ROBOT
global LONGUEUR_PAS_ROBOT
global ANGLE_VIRAGE_ROBOT

global robotCommandeRot
global robotCommandeTransl

switch button
    case 'up'
        roombaTravelDist(VITESSE_ROBOT, LONGUEUR_PAS_ROBOT)
        x = cosd(robotCommandeRot) * LONGUEUR_PAS_ROBOT;
        y = sind(robotCommandeRot) * LONGUEUR_PAS_ROBOT;
        robotCommandeTransl = robotCommandeTransl + [x y];
    case 'down'
        roombaTravelDist(VITESSE_ROBOT, -LONGUEUR_PAS_ROBOT)
        x = cosd(robotCommandeRot) * LONGUEUR_PAS_ROBOT;
        y = sind(robotCommandeRot) * LONGUEUR_PAS_ROBOT;
        robotCommandeTransl = robotCommandeTransl - [x y];
    case 'left'
        roombaTurnAngle(VITESSE_ROBOT, ANGLE_VIRAGE_ROBOT)
        robotCommandeRot = robotCommandeRot + ANGLE_VIRAGE_ROBOT;
    case 'right'
        roombaTurnAngle(VITESSE_ROBOT, -ANGLE_VIRAGE_ROBOT)
        robotCommandeRot = robotCommandeRot - ANGLE_VIRAGE_ROBOT;
    otherwise
        % rien
end 
        

