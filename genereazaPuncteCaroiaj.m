function puncteCaroiaj = genereazaPuncteCaroiaj(img,nrPuncteX,nrPuncteY,margine)
% genereaza puncte pe baza unui caroiaj
% un caroiaj este o retea de drepte orizontale si verticale de forma urmatoare:
%
%        |   |   |   |
%      --+---+---+---+--
%        |   |   |   |
%      --+---+---+---+--
%        |   |   |   |
%      --+---+---+---+--
%        |   |   |   |
%      --+---+---+---+--
%        |   |   |   |
%
% Input:
%       img - imaginea input
%       nrPuncteX - numarul de drepte verticale folosit la constructia caroiajului
%                 - in desenul de mai sus aceste drepte sunt identificate cu simbolul |
%       nrPuncteY - numarul de drepte orizontale folosit la constructia caroiajului
%                 - in desenul de mai sus aceste drepte sunt identificate cu simbolul --
%         margine - numarul de pixeli de la marginea imaginii (sus, jos, stanga, dreapta) pentru care nu se considera puncte
% Output:
%       puncteCaroiaj - matrice (nrPuncteX * nrPuncteY) X 2
%                     - fiecare linie reprezinta un punct (y,x) de pe caroiaj aflat la intersectia dreptelor orizontale si verticale
%                     - in desenul de mai sus aceste puncte sunt idenficate cu semnul +

puncteCaroiaj = zeros(nrPuncteX*nrPuncteY,2);

%completati codul
nrLinii = size(img, 1);
nrColoane = size(img, 2);

nrLinii = nrLinii - 2*margine;
nrColoane = nrColoane - 2*margine;

dist_dr_vert = floor(nrColoane/(nrPuncteX - 1));
dist_dr_oriz = floor(nrLinii/(nrPuncteY - 1));

pixeliRamasiX = floor((nrColoane - dist_dr_vert*(nrPuncteX-1))/2);
pixeliRamasiY = floor((nrColoane - dist_dr_oriz*(nrPuncteY-1))/2);

punct_start = [margine+pixeliRamasiY, margine+pixeliRamasiX];

for i = 1:nrPuncteY
    for j = 1:nrPuncteX
        puncteCaroiaj((i-1)*nrPuncteY+j, :) = punct_start;
        punct_start(2) = punct_start(2) + dist_dr_vert;
    end
    punct_start(1) = punct_start(1) + dist_dr_oriz;
    punct_start(2) = margine + pixeliRamasiX;
end


end