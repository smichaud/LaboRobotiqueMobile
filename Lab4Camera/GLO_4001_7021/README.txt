Pour éviter de perdre du temps à générer les fichiers .ps des tag, je vous en donne 10 gratuits! Si vous voulez en générer d'autres qui sont compatibles avec mes scripts (car j'ai un peu traficoté le code original), faites la commande python suivante :

C:\Python27\python generate_pattern.py -r 1 -c 1 -s 3 -o NumeroDuTag -f NomQuelconque
où NumeroDuTag est le numéro que vous voulez donner au code. Le fichier NomQuelconque.mat généré ne servira à rien, car je vous donne Patron1chiffre.mat déjà. Ce fichier Patron1chiffre.mat doit être donné à la fonction de décodage caltag_glo4001_extraire()


Pour un test rapide, faites tourner le script ExempleApplication.m

Attention! pour une raison que j'ignore, le numéro de tag retourné par caltag_glo4001_extraire() diffère légèrement de celui du nom de fichier Patron*.ps. 

Site du logiciel:
http://www.cs.ubc.ca/nest/imager/tr/2010/Atcheson_VMV2010_CALTag/
