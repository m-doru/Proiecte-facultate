%citeste imaginea
img = imread('../data/rice.jpg');
imgDest = imread('../data/eminescu.jpg');
i = 1;
n = 3;
%seteaza parametri
parametri.texturaInitiala = img;
parametri.imagineDestinatie = imgDest;
% parametri.dimensiuneTexturaSintetizata = [2*size(img,1) 2*size(img,2)];
parametri.dimensiuneBloc = 55;

parametri.nrBlocuri = 2000;
parametri.tradeoff = 0.8 * (i-1)/(n-1)+0.1;
parametri.eroareTolerata = 0.1;
parametri.portiuneSuprapunere = 1/6;

imgSintetizata = realizeazaTransferulTexturii(parametri);