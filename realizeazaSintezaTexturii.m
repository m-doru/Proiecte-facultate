function imgSintetizata = realizeazaSintezaTexturii(parametri)

dimBloc = parametri.dimensiuneBloc;
nrBlocuri = parametri.nrBlocuri;

[inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);
H = inaltimeTexturaInitiala;
W = latimeTexturaInitiala;
c = nrCanale;

H2 = parametri.dimensiuneTexturaSintetizata(1);
W2 = parametri.dimensiuneTexturaSintetizata(2);
overlap = parametri.portiuneSuprapunere;

% o imagine este o matrice cu 3 dimensiuni: inaltime x latime x nrCanale
% variabila blocuri - matrice cu 4 dimensiuni: punem fiecare bloc (portiune din textura initiala) 
% unul peste altul 
dims = [dimBloc dimBloc c nrBlocuri];
blocuri = uint8(zeros(dims(1), dims(2),dims(3),dims(4)));

%selecteaza blocuri aleatoare din textura initiala
%genereaza (in maniera vectoriala) punctul din stanga sus al blocurilor
y = randi(H-dimBloc+1,nrBlocuri,1);
x = randi(W-dimBloc+1,nrBlocuri,1);
%extrage portiunea din textura initiala continand blocul
for i =1:nrBlocuri
    blocuri(:,:,:,i) = parametri.texturaInitiala(y(i):y(i)+dimBloc-1,x(i):x(i)+dimBloc-1,:);
end


switch parametri.metodaSinteza
    
    case 'blocuriAleatoare'
        %%
        %completeaza imaginea de obtinut cu blocuri aleatoare
        
        imgSintetizata = uint8(zeros(H2,W2,c));
        nrBlocuriY = ceil(size(imgSintetizata,1)/dimBloc);
        nrBlocuriX = ceil(size(imgSintetizata,2)/dimBloc);
        imgSintetizataMaiMare = uint8(zeros(nrBlocuriY * dimBloc,nrBlocuriX * dimBloc,size(parametri.texturaInitiala,3)));
        for y=1:nrBlocuriY
            for x=1:nrBlocuriX
                indice = randi(nrBlocuri);
                imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:)=blocuri(:,:,:,indice);
            end
        end
        
        imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
        
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imgSintetizata);
        figure, imshow(imgSintetizataMaiMare);
        title('Rezultat obtinut pentru blocuri selectatate aleator');
        return

    
    case 'eroareSuprapunere'
        %%
        %completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere
        imgSintetizata = uint8(zeros(H2, W2, c));
        [nrBlocuriX, nrBlocuriY, dimX, dimY] = determinaDimensiuni(imgSintetizata, dimBloc, overlap);
        imgSintetizataMaiMare = uint8(zeros(dimX, dimY, 3));
        
        % completam primul rand
        indice = randi(nrBlocuri);
        imgSintetizataMaiMare(1:dimBloc, 1:dimBloc, :) = blocuri(:,:,:, indice);
        
        nrPixeliOverlapStanga = ceil(dimBloc*overlap);
        nrPixeliOverlapSus = ceil(dimBloc*overlap);
        
        progresDreapta = dimBloc;
        for i = 2:nrBlocuriX
            vecin = imgSintetizataMaiMare(1:dimBloc,progresDreapta-dimBloc+1:progresDreapta, :);
            bloc = determinaBlocEroareMinima(vecin, NaN, blocuri, overlap, parametri.eroareTolerata);
            imgSintetizataMaiMare(1:dimBloc, progresDreapta-nrPixeliOverlapStanga+1:progresDreapta+dimBloc-nrPixeliOverlapStanga, :) = bloc;
            progresDreapta = progresDreapta - nrPixeliOverlapStanga+ dimBloc;
        end
        
        progresDreapta = 0;
        progresJos = dimBloc;
        for i = 2:nrBlocuriX
            for j = 1:nrBlocuriY
                if j == 1
                    %determinam vecinul de sus
                    vecin = imgSintetizataMaiMare(progresJos-dimBloc+1:progresJos, 1:dimBloc, :);
                    %determinam blocul cu eroare in limita acceptata
                    bloc = determinaBlocEroareMinima(NaN, vecin, blocuri, overlap, parametri.eroareTolerata);
                    %inseram blocul
                    imgSintetizataMaiMare(progresJos - nrPixeliOverlapSus + 1 : progresJos + dimBloc - nrPixeliOverlapSus, 1:dimBloc, :) = bloc;
                    %avansam progresul
                    progresDreapta = dimBloc;
                else
                    %determinam vecin stanga
                    vecinStanga = imgSintetizataMaiMare(progresJos+1-nrPixeliOverlapSus:progresJos+dimBloc-nrPixeliOverlapSus...
                        ,progresDreapta-dimBloc+1:progresDreapta, :);
                    %determinam vecin sus
                    vecinSus = imgSintetizataMaiMare(progresJos-dimBloc+1:progresJos, ...
                        progresDreapta+1-nrPixeliOverlapStanga:progresDreapta+dimBloc-nrPixeliOverlapStanga, :);
                    %determinam blocul cu eroare in limita acceptata
                    bloc = determinaBlocEroareMinima(vecinStanga, vecinSus, blocuri, overlap, parametri.eroareTolerata);
                    %inseram blocul
                    imgSintetizataMaiMare(progresJos+1-nrPixeliOverlapSus:progresJos+dimBloc-nrPixeliOverlapSus,...
                        progresDreapta+1-nrPixeliOverlapStanga:progresDreapta+dimBloc-nrPixeliOverlapStanga, :) = bloc;
                    progresDreapta = progresDreapta - nrPixeliOverlapStanga + dimBloc;
                end
            end
            progresJos = progresJos - nrPixeliOverlapSus + dimBloc;
        end
        imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
        
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imgSintetizata);
        figure, imshow(imgSintetizataMaiMare);
        title('Rezultat obtinut pentru blocuri selectatate cu eroare de suprapunere minima');
        
        %completam prima coloana
	case 'frontieraCostMinim'
        %
        %completeaza imaginea de obtinut cu blocuri alese in functie de eroare de suprapunere + forntiera de cost minim
        imgSintetizata = uint8(zeros(H2, W2, c));
        [nrBlocuriX, nrBlocuriY, dimX, dimY] = determinaDimensiuni(imgSintetizata, dimBloc, overlap);
        imgSintetizataMaiMare = uint8(zeros(dimX, dimY, 3));
        
        % completam primul rand
        indice = randi(nrBlocuri);
        imgSintetizataMaiMare(1:dimBloc, 1:dimBloc, :) = blocuri(:,:,:, indice);
        
        nrPixeliOverlapStanga = ceil(dimBloc*overlap);
        nrPixeliOverlapSus = ceil(dimBloc*overlap);
        
        progresDreapta = dimBloc;
        for i = 2:nrBlocuriY
            vecin = imgSintetizataMaiMare(1:dimBloc,progresDreapta-dimBloc+1:progresDreapta, :);
            bloc = determinaBlocEroareMinima(vecin, NaN, blocuri, overlap, parametri.eroareTolerata);
            
            overlapVecin = vecin(:, size(vecin, 2)-nrPixeliOverlapStanga + 1 : size(vecin,2), :);
            overlapBloc = bloc(:, 1:nrPixeliOverlapStanga, :);
            restBloc = bloc(:, nrPixeliOverlapStanga+1:end,:);
            
            [overlapBlocuri, ~] = determinaOverlapCuFrontieraMinima(overlapVecin, overlapBloc);
            
%             imgSintetizataMaiMare(1:dimBloc, progresDreapta-nrPixeliOverlapStanga+1:progresDreapta,:) = overlapBlocuri;
%             imgSintetizataMaiMare(1:dimBloc, progresDreapta+1:progresDreapta+dimBloc-nrPixeliOverlapStanga, :) = restBloc;
            
            imgSintetizataMaiMare(1:dimBloc, progresDreapta - nrPixeliOverlapStanga + 1 : progresDreapta + dimBloc-nrPixeliOverlapStanga, :) = [overlapBlocuri restBloc];
            
            progresDreapta = progresDreapta - nrPixeliOverlapStanga+ dimBloc;
        end
        
        
        progresJos = dimBloc;
        for i = 2:nrBlocuriX
            % sintetizam primul bloc de pe linie
            %extragem vecin de deasupra
            vecin = imgSintetizataMaiMare(progresJos-dimBloc+1:progresJos, 1:dimBloc, :);
            %determinam bloc cu eroare in limita tolerata
            bloc = determinaBlocEroareMinima(NaN, vecin, blocuri, overlap, parametri.eroareTolerata);

            %extragem regiunile de overlap
            overlapVecin = vecin(size(vecin,1)-nrPixeliOverlapSus+1:size(vecin,1), :, :);
            overlapBloc = bloc(1:nrPixeliOverlapSus, :,:);
            %extragem regiunea din blocul de adaugat care nu face parte din overlap 
            restBloc = bloc(nrPixeliOverlapSus+1:end, :, :);
            
            % transpunem regiunea de overlap pe verticala ca sa folosim aceeasi
            % functie de determinare a drumului de cost minim
            [overlapBlocuri, ~] = determinaOverlapCuFrontieraMinima(imrotate(overlapBloc, -90), imrotate(overlapVecin, -90));
            % aducem regiunea de overlap la orientarea originala
            overlapBlocuri = imrotate(overlapBlocuri, 90);
            
            % inseram blocul in imaginea sintetizata
            imgSintetizataMaiMare(progresJos-nrPixeliOverlapSus+1:progresJos, 1:dimBloc, :) = overlapBlocuri;
            imgSintetizataMaiMare(progresJos+1:progresJos+dimBloc-nrPixeliOverlapSus, 1:dimBloc, :) = restBloc;
            progresDreapta = dimBloc;
            
            for j = 2:nrBlocuriY
                vecinStanga = imgSintetizataMaiMare(progresJos+1-nrPixeliOverlapSus:progresJos+dimBloc-nrPixeliOverlapSus,...
                    progresDreapta-dimBloc+1:progresDreapta, :);
                vecinSus = imgSintetizataMaiMare(progresJos-dimBloc+1:progresJos,...
                    progresDreapta-nrPixeliOverlapStanga+1:progresDreapta+dimBloc-nrPixeliOverlapStanga, :);

                overlapVecinStanga = vecinStanga(1:end, end-nrPixeliOverlapStanga + 1 : end, :);
                overlapVecinSus = vecinSus(end-nrPixeliOverlapSus + 1:end, 1:end, :);

                bloc = determinaBlocEroareMinima(vecinStanga, vecinSus, blocuri, overlap, parametri.eroareTolerata);

                overlapBlocStanga = bloc(1:dimBloc, 1:nrPixeliOverlapStanga, :);
                overlapBlocSus = bloc(1:nrPixeliOverlapSus, 1:dimBloc, :);

                [overlapBlocuriStanga, drumStanga] = determinaOverlapCuFrontieraMinima(overlapVecinStanga, overlapBlocStanga);
                [overlapBlocuriSus, drumSus] = determinaOverlapCuFrontieraMinima(imrotate(overlapBlocSus, -90), imrotate(overlapVecinSus, -90));
                overlapBlocuriSus = imrotate(overlapBlocuriSus, 90);

                %transpundem drumSus pe orizontala
                drumSus = transpunePeOrizontala(drumSus, size(overlapBlocuriSus, 1));

                %determinam punctele la care se intersecteaza cele doua
                %drumuri
                blocDubluOverlap = determinaBlocDubluOverlap(overlapBlocuriStanga, drumStanga, overlapBlocuriSus, drumSus, nrPixeliOverlapStanga);

                %inseram in imgSintetizataMaiMare cele 3 overlapuri
                
                blocTerminat = [blocDubluOverlap overlapBlocuriSus(:, nrPixeliOverlapStanga+1:end, :);...
                                overlapBlocuriStanga(nrPixeliOverlapSus+1:end, :, :) bloc(nrPixeliOverlapSus+1:end, nrPixeliOverlapStanga+1:end, :)];
                
                imgSintetizataMaiMare(progresJos-nrPixeliOverlapSus+1:progresJos+dimBloc-nrPixeliOverlapSus,...
                    progresDreapta-nrPixeliOverlapStanga+1:progresDreapta+dimBloc-nrPixeliOverlapStanga, :) = blocTerminat;
                progresDreapta = progresDreapta + dimBloc - nrPixeliOverlapStanga;
%                 %inseram blocul care se suprapune de 2 ori
%                 imgSintetizataMaiMare(progresJos-nrPixeliOverlapSus+1:progresJos,...
%                     progresDreapta-nrPixeliOverlapStanga+1:progresDreapta, :) = blocDubluOverlap;
%                 %inseram portiunea overlap de la stanga
%                 imgSintetizataMaiMare(progresJos+1:progresJos+dimBloc-nrPixeliOverlapSus,...
%                     progresDreapta-nrPixeliOverlapStanga+1:progresDreapta, :) = overlapBlocuriStanga(nrPixeliOverlapSus+1:end, :, :);
%                 %inseram portiunea overlap de sus
%                 imgSintetizataMaiMare(progresJos-nrPixeliOverlapSus+1:progresJos,...
%                     progresDreapta+1:progresDreapta+dimBloc-nrPixeliOverlapStanga, :) = overlapBlocuriSus(:, nrPixeliOverlapStanga+1:end, :);
%                 
%                 %copiem in imgSintetizataMaiMare restul blocului de adaugat
%                 
%                 imgSintetizataMaiMare(progresJos+1:progresJos+dimBloc-nrPixeliOverlapSus,...
%                     progresDreapta+1:progresDreapta+dimBloc-nrPixeliOverlapStanga, :) =...
%                     bloc(nrPixeliOverlapSus+1:end, nrPixeliOverlapStanga+1:end, :);
            end
            progresJos = progresJos + dimBloc - nrPixeliOverlapSus;
        end
        
        imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
        
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imgSintetizata);
        figure, imshow(imgSintetizataMaiMare);
        title('Rezultat obtinut pentru blocuri selectatate cu frontiera minima');
end
       
    
