function [detectii, scoruriDetectii, imageIdx, descriptoriDetectiiPozitive] = ruleazaDetectorFacial(parametri)
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

k = parametri.dimensiuneFereastra / parametri.dimensiuneCelulaHOG;
descriptoriDetectiiPozitive = zeros(0, k*k*31);

parfor i = 1:length(imgFiles)  
    fprintf('Rulam detectorul facial pe imaginea %s\n', imgFiles(i).name)
    imgOrig = imread(fullfile( parametri.numeDirectorExempleTest, imgFiles(i).name ));    
    if(size(imgOrig,3) > 1)
        imgOrig = rgb2gray(imgOrig);
    end    
    %completati codul functiei in continuare
    
    [redimLinii, redimColoane] = obtineDimensiuniRedimensionare(imgOrig, 1.1, 0.95);
    detectiiCurente = zeros(0,4);
    scoruriDetectiiCurente = zeros(0,1);
    imageIdxCurente = cell(0,1);
    descriptoriDetectiiPozitiveCurente = zeros(0, k*k*31);
    for q = 1:length(redimLinii)
        
        img = imresize(imgOrig, [redimLinii(q), redimColoane(q)]);
        
        descriptorHOG = vl_hog(single(img), parametri.dimensiuneCelulaHOG);
        for p = 1:size(descriptorHOG, 1)-k+1
            for j = 1:size(descriptorHOG, 2)-k+1
                
                patch = descriptorHOG(p:p+k-1, j:j+k-1, :);
                
                scor = patch(:)'*parametri.w + parametri.b;
                
                if scor > parametri.threshold
                    [xmin, ymin, xmax, ymax] = obtineDimensiuniFereastra(imgOrig, img, p, j, parametri.dimensiuneCelulaHOG, parametri.dimensiuneFereastra);
                    detectiiCurente(end+1, :) = [xmin, ymin, xmax, ymax];
                    
                    scoruriDetectiiCurente(end+1) = scor;
                    
                    imageIdxCurente{end+1} = imgFiles(i).name;
                    
                    imgPatch = img(p:p+parametri.dimensiuneFereastra-1, j:j+parametri.dimensiuneFereastra-1);
                    descriptorTemp = vl_hog(single(imgPatch), parametri.dimensiuneCelulaHOG);
                    
                    
                    descriptoriDetectiiPozitiveCurente(end+1, :) = descriptorTemp(:);
                end
            end
        end
    
    end
    
    if size(detectiiCurente, 1) > 0
        esteMaxim = eliminaNonMaximele(detectiiCurente, scoruriDetectiiCurente, size(imgOrig));
        
        detectiiMaxime = detectiiCurente(esteMaxim, :);
        scoruriMaxime = scoruriDetectiiCurente(esteMaxim);
        imageIdxMaxim = imageIdxCurente(esteMaxim);
        descriptoriMaxime = descriptoriDetectiiPozitiveCurente(esteMaxim, :);
        
        detectii = [detectii; detectiiMaxime];
        scoruriDetectii = [scoruriDetectii scoruriMaxime];
        imageIdx = [imageIdx imageIdxMaxim];
        descriptoriDetectiiPozitive = [descriptoriDetectiiPozitive; descriptoriMaxime];
    end
end


end

