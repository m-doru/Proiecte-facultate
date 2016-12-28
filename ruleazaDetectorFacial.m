function [detectii, scoruriDetectii, imageIdx] = ruleazaDetectorFacial(parametri)
% 'detectii' = matrice Nx4, unde 
%           N este numarul de detectii  
%           detectii(i,:) = [x_min, y_min, x_max, y_max]
% 'scoruriDetectii' = matrice Nx1. scoruriDetectii(i) este scorul detectiei i
% 'imageIdx' = tablou de celule Nx1. imageIdx{i} este imaginea in care apare detectia i
%               (nu punem intregul path, ci doar numele imaginii: 'albert.jpg')

% Aceasta functie returneaza toate detectiile ( = ferestre) pentru toate imaginile din parametri.numeDirectorExempleTest
% Directorul cu numele parametri.numeDirectorExempleTest contine imagini ce
% pot sau nu contine fete. Aceasta functie ar trebui sa detecteze fete atat pe setul de
% date MIT+CMU dar si pentru alte imagini (imaginile realizate cu voi la curs+laborator).
% Functia 'suprimeazaNonMaximele' suprimeaza detectii care se suprapun (protocolul de evaluare considera o detectie duplicata ca fiind falsa)
% Suprimarea non-maximelor se realizeaza pe pentru fiecare imagine.

% Functia voastra ar trebui sa calculeze pentru fiecare imagine
% descriptorul HOG asociat. Apoi glisati o fereastra de dimeniune paremtri.dimensiuneFereastra x  paremtri.dimensiuneFereastra (implicit 36x36)
% si folositi clasificatorul liniar (w,b) invatat poentru a obtine un scor. Daca acest scor este deasupra unui prag (threshold) pastrati detectia
% iar apoi mporcesati toate detectiile prin suprimarea non maximelor.
% pentru detectarea fetelor de diverse marimi folosit un detector multiscale

imgFiles = dir( fullfile( parametri.numeDirectorExempleTest, '*.jpg' ));
%initializare variabile de returnat
detectii = zeros(0,4);
scoruriDetectii = zeros(0,1);
imageIdx = cell(0,1);

for i = 1:length(imgFiles)      
    fprintf('Rulam detectorul facial pe imaginea %s\n', imgFiles(i).name)
    imgOrig = imread(fullfile( parametri.numeDirectorExempleTest, imgFiles(i).name ));    
    if(size(imgOrig,3) > 1)
        imgOrig = rgb2gray(imgOrig);
    end    
    %completati codul functiei in continuare
    %trebuie sa redimensionez imaginea, dar cum fac asta?
    
    [redimLinii, redimColoane] = obtineDimensiuneRedimensionare(imgOrig);
    
    for q = 1:length(redimLinii)
        
        img = imresize(imgOrig, [redimLinii(q), redimColoane(q)]);
        
        descriptorHOG = vl_hog(single(img), parametri.dimensiuneCelulaHOG);
        k = parametri.dimensiuneFereastra / parametri.dimensiuneCelulaHOG;
        for p = 1:size(descriptorHOG, 1)-k+1
            for j = 1:size(descriptorHOG, 2)-k+1
                patch = descriptorHOG(p:p+k-1, j:j+k-1, :);
                scor = patch(:)'*parametri.w + parametri.b;
                if scor > 0
                    detectii(end+1, :) = [(j-1)*k+1, (p-1)*k+1, (j-1)*k+parametri.dimensiuneFereastra, (p-1)*k+parametri.dimensiuneFereastra];
                    scoruriDetectii(end+1) = scor;
                    imageIdx{end+1} = imgFiles(i).name;
                end
            end
        end
    
    end
end




