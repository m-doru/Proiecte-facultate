% Structura codului:
% ruleazaProiect.m                                <--- (optional) completati pasul 3
%  + obtineDescriptoriExemplePozitive.m           <--- trebuie sa completati aceasta functie
%  + obtineDescriptoriExempleNegative.m           <--- trebuie sa completati aceasta functie
%  + antreneazaClasificator.m                     <--- functie scrisa in intregime
%    + calculeazaAcurateteClasificator.m          <--- functie scrisa in intregime
%  + vizualizeazaTemplateHOG.m                    <--- functie scrisa in intregime
%  + calculeazaPrecizieClasificator.m             <--- functie scrisa in intregime
%  + ruleazaDetectorFacial.m                      <--- trebuie sa completati aceasta functie
%    + eliminaNonMaximele.m                       <--- functie scrisa in intregime
%  + evalueazaDetectii.m                          <--- functie scrisa in intregime
%    + calculeazaPrecizieClasificator.m           <--- functie scrisa in intregime
%  + vizualizeazaDetectiiInImagineCuAdnotari.m    <--- functie scrisa in intregime
%  + vizualizeazaDetectiiInImagineFaraAdnotari.m  <--- functie scrisa in intregime

%% Pasul 0 - initializam parametri
%seteaza path-urile pentru seturile de date: antrenare, test
clear;
clc;
close all;
tic;
numeDirectorSetDate = '../data/'; %
parametri.numeDirectorExemplePozitive = fullfile(numeDirectorSetDate, 'exemplePozitive2');                                   %exemple pozitive de antrenare: 36x36 fete cropate
parametri.numeDirectorExempleNegative = fullfile(numeDirectorSetDate, 'exempleNegative2');                                   %exemple negative de antrenare: imagini din care trebuie sa selectati ferestre 36x36
parametri.numeDirectorExempleTest = fullfile(numeDirectorSetDate,'exempleTest/CMU+MIT');                                    %exemple test din dataset-ul CMU+MIT
% parametri.numeDirectorExempleTest=fullfile(numeDirectorSetDate,'exempleTest/Curs+LaboratorIA');                            %exemple test realizate la laborator si curs
parametri.numeDirectorAdnotariTest = fullfile(numeDirectorSetDate,'exempleTest/CMU+MIT_adnotari/ground_truth_bboxes.txt');  %fisierul cu adnotari pentru exemplele test din dataset-ul CMU+MIT
% parametri.numeDirectorExempleTest = fullfile(numeDirectorSetDate, 'exempleTest/blackwhite');
parametri.existaAdnotari = 1;
parametri.numeDirectorSalveazaFisiere = fullfile(numeDirectorSetDate,'salveazaFisiere/');
mkdir(parametri.numeDirectorSalveazaFisiere);
%seteaza valori pentru diferiti parametri
parametri.dimensiuneFereastra = 36;              %exemplele pozitive (fete de oameni cropate) au 36x36 pixeli
parametri.dimensiuneCelulaHOG = 4;               %dimensiunea celulei
parametri.dimensiuneDescriptorCelula = 31;       %dimensiunea descriptorului unei celule
parametri.overlap = 0.3;                         %cat de mult trebuie sa se suprapuna doua detectii pentru a o elimina pe cea cu scorul mai mic
parametri.antrenareCuExemplePuternicNegative = 1;%(optional)antrenare cu exemple puternic negative
parametri.numarExemplePozitive = 6713*2;         %numarul exemplelor pozitive
parametri.numarExempleNegative = 40000;          %numarul exemplelor negative
parametri.threshold = 0;                         %toate ferestrele cu scorul > threshold si maxime locale devin detectii
parametri.vizualizareTemplateHOG = 1;            %vizualizeaza template HOG

%% 
%Pasul 1. Incarcam exemplele pozitive (cropate) si exemple negative generate
%exemple pozitive
try
    numeFisierDescriptoriExemplePozitive = [parametri.numeDirectorSalveazaFisiere 'descriptoriExemplePozitive_' num2str(parametri.dimensiuneCelulaHOG) '_' ...
        num2str(parametri.numarExemplePozitive) '.mat'];
    temp = load(numeFisierDescriptoriExemplePozitive);
    descriptoriExemplePozitive = temp.descriptoriExemplePozitive;
    disp('Am incarcat descriptorii pentru exemplele pozitive');
catch
    disp('Construim descriptorii pentru exemplele pozitive:');
    descriptoriExemplePozitive = obtineDescriptoriExemplePozitive(parametri);
    save(numeFisierDescriptoriExemplePozitive,'descriptoriExemplePozitive','-v7.3');
    disp(['Am salvat descriptorii pentru exemplele pozitive in fisierul ' numeFisierDescriptoriExemplePozitive]);
end

%exemple negative
%redimensioneaza imaginile cand extragi exemplele negative
try
    numeFisierDescriptoriExempleNegative = [parametri.numeDirectorSalveazaFisiere 'descriptoriExempleNegative_' num2str(parametri.dimensiuneCelulaHOG) '_' ...
        num2str(parametri.numarExempleNegative) '.mat'];
    temp = load(numeFisierDescriptoriExempleNegative);
    descriptoriExempleNegative = temp.descriptoriExempleNegative;
    disp('Am incarcat descriptorii pentru exemplele negative');
catch    
    disp('Construim descriptorii pentru exemplele negative:');
    descriptoriExempleNegative = obtineDescriptoriExempleNegative(parametri);
    save(numeFisierDescriptoriExempleNegative,'descriptoriExempleNegative','-v7.3');
     disp(['Am salvat descriptorii pentru exemplele negative in fisierul ' numeFisierDescriptoriExempleNegative]);
end

disp('Am obtinut exemplele de antrenare');

%%
%Pasul 2. Invatam clasificatorul liniar
 exempleAntrenare = [descriptoriExemplePozitive;descriptoriExempleNegative]';
 eticheteExempleAntrenare = [ones(size(descriptoriExemplePozitive,1),1); -1*ones(size(descriptoriExempleNegative,1),1)];
 [w, b] = antreneazaClasificator(exempleAntrenare,eticheteExempleAntrenare);
 parametri.w = w;
 parametri.b = b; 
%vizualizare model invatat HOG
if parametri.vizualizareTemplateHOG
    vizualizeazaTemplateHOG(parametri);    
end
%% 
% Pasul 3. (optional) Antrenare cu exemple puternic negative (detectii cu scor >0 din cele 274 de imagini negative)
% Daca implementati acest pas ar trebui sa modificati functia ruleazaDetectorFacial.m
% astfel incat sa va returneze descriptorii detectiilor cu scor >0 din cele 274 imagini negative
% completati codul in continuare

if (parametri.antrenareCuExemplePuternicNegative)

    try
        numeFisierDescriptoriExemplePuternicNegative = [parametri.numeDirectorSalveazaFisiere 'descriptoriExemplePuternicNegative_' num2str(parametri.dimensiuneCelulaHOG) '_' ...
            num2str(parametri.numarExempleNegative) '.mat'];
        temp = load(numeFisierDescriptoriExemplePuternicNegative);
        descriptoriExemplePuternicNegative = temp.descriptoriExemplePuternicNegative;
        disp('Am incarcat descriptorii pentru exemplele puternic negative');
    catch    
        disp('Construim descriptorii pentru exemplele puternic negative:');

        dirExempleTest = parametri.numeDirectorExempleTest;

        parametri.numeDirectorExempleTest = parametri.numeDirectorExempleNegative;

        [d, s, idx, descriptoriExemplePuternicNegative] = ruleazaDetectorFacial(parametri);

        disp('Am obtinut exemplele puternic negative');

        parametri.numeDirectorExempleTest = dirExempleTest;

        save(numeFisierDescriptoriExemplePuternicNegative,'descriptoriExemplePuternicNegative','-v7.3');
         disp(['Am salvat descriptorii pentru exemplele puternic negative in fisierul ' numeFisierDescriptoriExemplePuternicNegative]);
    end
    
    % reantrenare cu exemple puternic negative
    disp('Reantrenam cu exemplele puternic negative');
    exempleAntrenare = [descriptoriExemplePozitive;...
        descriptoriExempleNegative;...
        descriptoriExemplePuternicNegative]';
     eticheteExempleAntrenare = [ones(size(descriptoriExemplePozitive,1),1);...
         -1*ones(size(descriptoriExempleNegative,1),1); ...
         -1*ones(size(descriptoriExemplePuternicNegative, 1), 1)];
     [w, b] = antreneazaClasificator(exempleAntrenare,eticheteExempleAntrenare);
     parametri.w = w;
     parametri.b = b; 
    %vizualizare model invatat HOG
    if parametri.vizualizareTemplateHOG
        vizualizeazaTemplateHOG(parametri);    
    end
end

%% 
% Pasul 4. Ruleaza detectorul facial pe imaginile de test.
[detectii, scoruriDetectii, imageIdx] = ruleazaDetectorFacial(parametri);

toc
%% 
% Pasul 5. Evalueaza si vizualizeaza detectiile
% Pentru imagini pentru care exista adnotari (cele din setul de date  CMU+MIT) folositi functia vizualizeazaDetectiiInImagineCuAdnotari.m,
% pentru imagini fara adnotari (cele realizate la curs si laborator) folositi functia vizualizeazaDetectiiInImagineFaraAdnotari.m,

if (parametri.existaAdnotari )
    [gt_ids, gt_detectii, gt_existaDetectie, tp, fp, detectii_duplicat] = evalueazaDetectii(detectii, scoruriDetectii, imageIdx, parametri.numeDirectorAdnotariTest);
    vizualizeazaDetectiiInImagineCuAdnotari(detectii, scoruriDetectii, imageIdx, tp, fp, parametri.numeDirectorExempleTest, parametri.numeDirectorAdnotariTest);
else
    vizualizeazaDetectiiInImagineFaraAdnotari(detectii, scoruriDetectii, imageIdx, parametri.numeDirectorExempleTest);
end