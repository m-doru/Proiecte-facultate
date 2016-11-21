function [ nrBlocuriX, nrBlocuriY, dimX, dimY ] = determinaDimensiuni(imgSintetizata, dimBloc, overlap)

    h = size(imgSintetizata, 1);
    w = size(imgSintetizata, 2);
    
    h = h - dimBloc;
    w = w - dimBloc;
    
    nrBlocuriX = ceil(h / (dimBloc * (1-overlap)));
    nrBlocuriY = ceil(w / (dimBloc * (1-overlap)));

    dimX = dimBloc + nrBlocuriX * (ceil(dimBloc * (1-overlap)));
    dimY = dimBloc + nrBlocuriY * (ceil(dimBloc * (1-overlap)));
    
    nrBlocuriX = nrBlocuriX + 1;
    nrBlocuriY = nrBlocuriY + 1;
    
end