Pour �viter de perdre du temps � g�n�rer les fichiers .ps des tag, je vous en donne 10 gratuits! Si vous voulez en g�n�rer d'autres qui sont compatibles avec mes scripts (car j'ai un peu traficot� le code original), faites la commande python suivante :

C:\Python27\python generate_pattern.py -r 1 -c 1 -s 3 -o NumeroDuTag -f NomQuelconque
o� NumeroDuTag est le num�ro que vous voulez donner au code. Le fichier NomQuelconque.mat g�n�r� ne servira � rien, car je vous donne Patron1chiffre.mat d�j�. Ce fichier Patron1chiffre.mat doit �tre donn� � la fonction de d�codage caltag_glo4001_extraire()


Pour un test rapide, faites tourner le script ExempleApplication.m

Attention! pour une raison que j'ignore, le num�ro de tag retourn� par caltag_glo4001_extraire() diff�re l�g�rement de celui du nom de fichier Patron*.ps. 

Site du logiciel:
http://www.cs.ubc.ca/nest/imager/tr/2010/Atcheson_VMV2010_CALTag/
