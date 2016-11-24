function bloc = determinaBlocDubluOverlap(overlapStanga, drumIntregStanga, overlapSus, drumIntregSus, nrPixeliOverlap)
    patratStanga = overlapStanga(1:nrPixeliOverlap, 1:nrPixeliOverlap, :);
    drumStanga = drumIntregStanga(1:nrPixeliOverlap, :);
    patratSus = overlapSus(1:nrPixeliOverlap, 1:nrPixeliOverlap, :);
    drumSus = drumIntregSus(1:nrPixeliOverlap, :);
    
    % copiaza regiunea de deasupra drumSus din patratSus peste patratStanga
    for i = 1:size(drumSus, 1)
        patratStanga(1:drumSus(i,1), i, :) = patratSus(1:drumSus(i,1), i,:);
    end

    bloc = patratStanga;
end