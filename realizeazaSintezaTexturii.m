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
        
        nrPixeliOverlapStanga = ceil(size(blocuri(:,:,:,1), 2)*overlap);
        nrPixeliOverlapSus = ceil(size(blocuri(:,:,:,1), 1)*overlap);
        
        progresDreapta = dimBloc;
        for i = 2:nrBlocuriX
            vecin = imgSintetizataMaiMare(1:dimBloc,progresDreapta-dimBloc+1:progresDreapta, :);
            bloc = determinaBlocEroareMinima(vecin, NaN, blocuri, overlap);
            imgSintetizataMaiMare(1:dimBloc, progresDreapta-nrPixeliOverlapStanga+1:progresDreapta+dimBloc-nrPixeliOverlapStanga, :) = bloc;
            progresDreapta = progresDreapta - nrPixeliOverlapStanga + 1 + dimBloc;
        end
        
        progresDreapta = 0;
        progresJos = dimBloc;
        for i = 2:nrBlocuriX
            for j = 1:nrBlocuriY
                if j == 1
                    vecin = imgSintetizataMaiMare(progresJos-dimBloc+1:progresJos, 1:dimBloc, :);
                    bloc = determinaBlocEroareMinima(NaN, vecin, blocuri, overlap);
                    imgSintetizataMaiMare(progresJos - nrPixeliOverlapSus + 1 : progresJos + dimBloc - nrPixeliOverlapSus, 1:dimBloc, :) = bloc;
                    progresDreapta = dimBloc;
                else
                    vecinStanga = imgSintetizataMaiMare(progresJos+1-nrPixeliOverlapSus:progresJos+dimBloc-nrPixeliOverlapSus...
                        ,progresDreapta-dimBloc+1:progresDreapta, :);
                    vecinSus = imgSintetizataMaiMare(progresJos-dimBloc+1:progresJos, ...
                        progresDreapta+1-nrPixeliOverlapStanga:progresDreapta+dimBloc-nrPixeliOverlapStanga, :);
                    bloc = determinaBlocEroareMinima(vecinStanga, vecinSus, blocuri, overlap);
                    imgSintetizataMaiMare(progresJos+1-nrPixeliOverlapSus:progresJos+dimBloc-nrPixeliOverlapSus,...
                        progresDreapta+1-nrPixeliOverlapStanga:progresDreapta+dimBloc-nrPixeliOverlapStanga, :) = bloc;
                    progresDreapta = progresDreapta - nrPixeliOverlapStanga + 1 + dimBloc;
                end
            end
            progresJos = progresJos - nrPixeliOverlapSus + 1 + dimBloc;
        end
        imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
        
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imgSintetizata);
        figure, imshow(imgSintetizataMaiMare);
        title('Rezultat obtinut pentru blocuri selectatate cu eroare de suprapunere minima');
        
        %completam prima coloana
	case 'frontieraCostMinim'
        %
        %completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere + forntiera de cost minim
        
       
end
       
    
