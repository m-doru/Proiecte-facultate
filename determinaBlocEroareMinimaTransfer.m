function bloc = determinaBlocEroareMinimaTransfer(vecinStanga, vecinSus, blocSursa, blocuri, overlap, eroareTolerata, tradeoff)
    eroriStanga = zeros(1,size(blocuri, 4), 'double');
    eroriSus = zeros(1,size(blocuri, 4), 'double');
    eroriIntensitate = zeros(1, size(blocuri,4), 'double');
    
    nrPixeliOverlapStanga = ceil(size(blocuri(:,:,:,1), 2)*overlap);
    nrPixeliOverlapSus = ceil(size(blocuri(:,:,:,1), 1)*overlap);
    
    for i = 1:size(blocuri,4)
        if ~isnan(vecinStanga)
            latimeVecinStanga = size(vecinStanga, 2);
            overlapVecinStanga = vecinStanga(:, latimeVecinStanga-nrPixeliOverlapStanga+1:latimeVecinStanga, :);
            overlapBloc = blocuri(:, 1:nrPixeliOverlapStanga, :, i);
            eroriStanga(i) = calculeazaEroare(overlapVecinStanga, overlapBloc);
        end
        if ~isnan(vecinSus)
            inaltimeVecinSus = size(vecinSus, 1);
            overlapVecinSus = vecinSus(inaltimeVecinSus - nrPixeliOverlapSus+1:inaltimeVecinSus, :, :);
            overlapBloc = blocuri(1:nrPixeliOverlapSus, :, :, i);
            eroriSus(i) = calculeazaEroare(overlapVecinSus, overlapBloc);
        end
        eroriIntensitate(i) = calculeazaEroare(blocSursa, blocuri(:,:,:,i));
    end
    
    eroareOverlap = eroriStanga + eroriSus;
    eroriTotale = eroareOverlap.*tradeoff + (eroriIntensitate.^2).*(1-tradeoff);
    
    [eroareMinima, ~] = min(eroriTotale);
    
    eroareAcceptata = eroareMinima * (1+eroareTolerata);
    
    blocuriInEroareAcceptata = zeros(size(blocuri));
    
    i_blocuri = 1;
    for i = 1:size(blocuri, 4)
        eroareCurenta = eroriTotale(i);
        if eroareCurenta <= eroareAcceptata
            blocuriInEroareAcceptata(:,:,:, i_blocuri) = blocuri(:,:,:,i);
            i_blocuri = i_blocuri + 1;
        end
    end
    
    i_blocuri = i_blocuri - 1;
    index = randi(i_blocuri, 1);
    
    bloc = blocuriInEroareAcceptata(:,:,:,index);
    
end