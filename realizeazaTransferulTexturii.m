function imgSintetizata = realizeazaTransferulTexturii(parametri)

dimBloc = parametri.dimensiuneBloc;
nrBlocuri = parametri.nrBlocuri;
imgDestinatie = parametri.imagineDestinatie;

[inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);
H = inaltimeTexturaInitiala;
W = latimeTexturaInitiala;
c = nrCanale;

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

[nrBlocuriX, nrBlocuriY, dimX, dimY] = determinaDimensiuni(imgDestinatie, dimBloc, overlap);

imgRezultat = uint8(zeros(dimX, dimY, size(parametri.texturaInitiala,3)));
imgDestinatieMaiMare = imresize(imgDestinatie, [dimX, dimY]);
% completam primul bloc din prima linie
imgRezultat(1:dimBloc, 1:dimBloc, :) = determinaBlocEroareMinimaTransfer(NaN, NaN, ...
    imgDestinatieMaiMare(1:dimBloc, 1:dimBloc, :), blocuri, parametri.portiuneSuprapunere,...
    parametri.eroareTolerata, parametri.tradeoff);

nrPixeliOverlapStanga = ceil(dimBloc*overlap);
nrPixeliOverlapSus = ceil(dimBloc*overlap);

% completam restul primei linii
progresDreapta = dimBloc;
for i = 2:nrBlocuriY
    vecin = imgRezultat(1:dimBloc,progresDreapta-dimBloc+1:progresDreapta, :);
    blocDestinatie = imgDestinatieMaiMare(1:dimBloc, progresDreapta+1-nrPixeliOverlapStanga:progresDreapta+dimBloc-nrPixeliOverlapStanga, :);
    bloc = determinaBlocEroareMinimaTransfer(vecin, NaN, blocDestinatie, blocuri, overlap, parametri.eroareTolerata, parametri.tradeoff);

    overlapVecin = vecin(:, size(vecin, 2)-nrPixeliOverlapStanga + 1 : size(vecin,2), :);
    overlapBloc = bloc(:, 1:nrPixeliOverlapStanga, :);
    restBloc = bloc(:, nrPixeliOverlapStanga+1:end,:);

    [overlapBlocuri, ~] = determinaOverlapCuFrontieraMinima(overlapVecin, overlapBloc);

    imgRezultat(1:dimBloc, progresDreapta - nrPixeliOverlapStanga + 1 : progresDreapta + dimBloc-nrPixeliOverlapStanga, :) = [overlapBlocuri restBloc];

    progresDreapta = progresDreapta - nrPixeliOverlapStanga+ dimBloc;
end


progresJos = dimBloc;
for i = 2:nrBlocuriX
    % sintetizam primul bloc de pe linie
    % extragem vecin de deasupra
    vecin = imgRezultat(progresJos-dimBloc+1:progresJos, 1:dimBloc, :);
    % extragem blocul corespunzator din imaginea pe care dorim sa
    % transferam textura
    blocDestinatie = imgDestinatieMaiMare(progresJos+1-nrPixeliOverlapSus:progresJos+dimBloc-nrPixeliOverlapSus, 1:dimBloc, :);
    %determinam bloc cu eroare in limita tolerata
    bloc = determinaBlocEroareMinimaTransfer(NaN, vecin, blocDestinatie, blocuri, overlap, parametri.eroareTolerata, parametri.tradeoff);

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
    imgRezultat(progresJos-nrPixeliOverlapSus+1:progresJos+dimBloc-nrPixeliOverlapSus, 1:dimBloc, :) = [overlapBlocuri; restBloc];
    progresDreapta = dimBloc;

    for j = 2:nrBlocuriY
        % determinam vecinii
        vecinStanga = imgRezultat(progresJos+1-nrPixeliOverlapSus:progresJos+dimBloc-nrPixeliOverlapSus,...
            progresDreapta-dimBloc+1:progresDreapta, :);
        vecinSus = imgRezultat(progresJos-dimBloc+1:progresJos,...
            progresDreapta-nrPixeliOverlapStanga+1:progresDreapta+dimBloc-nrPixeliOverlapStanga, :);
        % extragem blocul corespunzator din imaginea destinatie
        blocDestinatie = imgDestinatieMaiMare(progresJos-nrPixeliOverlapSus+1:progresJos-nrPixeliOverlapSus+dimBloc,...
            progresDreapta-nrPixeliOverlapStanga+1:progresDreapta-nrPixeliOverlapStanga+dimBloc, :);
        
        % extragem regiunile de overlap ale vecinilor
        overlapVecinStanga = vecinStanga(1:end, end-nrPixeliOverlapStanga + 1 : end, :);
        overlapVecinSus = vecinSus(end-nrPixeliOverlapSus + 1:end, 1:end, :);

        % determinam blocul cu eroare minima
        bloc = determinaBlocEroareMinimaTransfer(vecinStanga, vecinSus, blocDestinatie, blocuri, overlap, parametri.eroareTolerata, parametri.tradeoff);

        % extragem regiunile de overlap din blocul determinam
        overlapBlocStanga = bloc(1:dimBloc, 1:nrPixeliOverlapStanga, :);
        overlapBlocSus = bloc(1:nrPixeliOverlapSus, 1:dimBloc, :);

        % determinam regiunile de overlap dupa suprapunerea bazata pe ideea
        % frontierei minime
        [overlapBlocuriStanga, drumStanga] = determinaOverlapCuFrontieraMinima(overlapVecinStanga, overlapBlocStanga);
        [overlapBlocuriSus, drumSus] = determinaOverlapCuFrontieraMinima(imrotate(overlapBlocSus, -90), imrotate(overlapVecinSus, -90));
        overlapBlocuriSus = imrotate(overlapBlocuriSus, 90);

        %transpundem drumSus pe orizontala
        drumSus = transpunePeOrizontala(drumSus, size(overlapBlocuriSus, 1));

        % determinam patratul in care se suprapun regiunile de overlap ale
        % celor 2 vecini
        blocDubluOverlap = determinaBlocDubluOverlap(overlapBlocuriStanga, drumStanga, overlapBlocuriSus, drumSus, nrPixeliOverlapStanga);

        % cream blocul de inserat 
        blocTerminat = [blocDubluOverlap overlapBlocuriSus(:, nrPixeliOverlapStanga+1:end, :);...
                        overlapBlocuriStanga(nrPixeliOverlapSus+1:end, :, :) bloc(nrPixeliOverlapSus+1:end, nrPixeliOverlapStanga+1:end, :)];

        % inseram blocul
        imgRezultat(progresJos-nrPixeliOverlapSus+1:progresJos+dimBloc-nrPixeliOverlapSus,...
            progresDreapta-nrPixeliOverlapStanga+1:progresDreapta+dimBloc-nrPixeliOverlapStanga, :) = blocTerminat;
        progresDreapta = progresDreapta + dimBloc - nrPixeliOverlapStanga;
        debug_afiseaza_imagine(imgRezultat);
        fprintf('Progres %2.2f done \n', single((i-1)*nrBlocuriY + j)/(nrBlocuriX*nrBlocuriY));
    end
    progresJos = progresJos + dimBloc - nrPixeliOverlapSus;
end

imgSintetizata = imgRezultat(1:size(imgDestinatie,1),1:size(imgDestinatie,2),:);

figure, imshow(parametri.texturaInitiala)
figure, imshow(imgSintetizata);
figure, imshow(imgRezultat);
title('Rezultat obtinut pentru blocuri selectatate cu frontiera minima');
end
       
    
