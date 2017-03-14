function [ nrBlocuriX, nrBlocuriY, dimX, dimY ] = determinaDimensiuni(imgSintetizata, dimBloc, overlap)

    h = size(imgSintetizata, 1);
    w = size(imgSintetizata, 2);
    
    h = h - dimBloc;
    w = w - dimBloc;
    
    nrBlocuriX = ceil(h / (dimBloc * (1-overlap)));
    nrBlocuriY = ceil(w / (dimBloc * (1-overlap)));

    dimX = 2*dimBloc + nrBlocuriX * (ceil(dimBloc * (1-overlap)));
    dimY = 2*dimBloc + nrBlocuriY * (ceil(dimBloc * (1-overlap)));
    
    nrBlocuriX = nrBlocuriX + 2;
    nrBlocuriY = nrBlocuriY + 2;
    
end