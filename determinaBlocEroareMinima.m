function bloc = determinaBlocEroareMinima(vecinStanga, vecinSus, blocuri, overlap)
    eroriStanga = zeros(1,size(blocuri, 4), 'int64');
    eroriSus = zeros(1,size(blocuri, 4), 'int64');
    
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
    end
    
    eroareMedie = mean([eroriStanga;eroriSus]);
    
    [~, index] = min(eroareMedie);
    
    bloc = blocuri(:,:,:,index);
    
end