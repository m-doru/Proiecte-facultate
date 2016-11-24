function [overlap , drum]= determinaOverlapCuFrontieraMinima(overlapVecin, overlapBloc)
    greyVecin = rgb2gray(overlapVecin);
    greyBloc = rgb2gray(overlapBloc);

    eroare = (double(greyVecin) - double(greyBloc)).^2;
    
    drum = determinaDrumCostMinim(eroare);
    
    overlap = uint8(zeros(size(overlapVecin)));
    
    for i = 1:size(drum,1)
        overlap(i, 1:drum(i, 2), :) =  overlapVecin(i, 1:drum(i,2),:);
        overlap(i, drum(i,2)+1:end, :) = overlapBloc(i, drum(i,2)+1:end, :);
    end
    
end