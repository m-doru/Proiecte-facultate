function [ imgMozaic ] = computeMozaic( caleImagineReferinta, directorPiese, tipImagine, criteriu, numarPieseOrizontala, afiseazaPieseMozaic )

%tema 1: REALIZAREA IMAGINILOR MOZAIC
%

%%
%seteaza parametri

%citeste imaginea care va fi transformata in mozaic
%puteti inlocui numele imaginii
params.imgReferinta = imread(caleImagineReferinta);

%seteaza directorul cu imaginile folosite la realizarea mozaicului
%puteti inlocui numele directorului
params.numeDirector = directorPiese;
params.tipImagine = tipImagine;

%seteaza numarul de piese ale mozaicului pe orizontala
%puteti inlocui aceasta valoare
params.numarPieseMozaicOrizontala = numarPieseOrizontala;
%numarul de piese ale mozaciului pe verticala va fi dedus automat

%seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din
%director
params.afiseazaPieseMozaic = afiseazaPieseMozaic;

%seteaza criteriul dupa care realizeze mozaicul
%optiuni: 'aleator','distantaCuloareMedie','distantaCulori'
params.criteriu = criteriu;
%params.criteriu = 'distantaCulori';

%%
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);
%imwrite(imgMozaic,'mozaic.jpg');
%mozaic = figure, imshow(imgMozaic);


end

