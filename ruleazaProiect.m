%citeste imaginea
img = imread('../data/radishes.jpg');
%seteaza parametri
parametri.texturaInitiala = img;
parametri.dimensiuneTexturaSintetizata = [2*size(img,1) 2*size(img,2)];
parametri.dimensiuneBloc = 55;

parametri.nrBlocuri = 2000;
parametri.eroareTolerata = 0.1;
parametri.portiuneSuprapunere = 1/6;
% parametri.metodaSinteza = 'blocuriAleatoare';
% parametri.metodaSinteza = 'eroareSuprapunere';
parametri.metodaSinteza = 'frontieraCostMinim';

imgSintetizata = realizeazaSintezaTexturii(parametri);