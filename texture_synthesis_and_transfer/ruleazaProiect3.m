%citeste imaginea
imgName = 'img11';
imgFmt = '.png';
img = imread(['../data/' imgName imgFmt]);
%seteaza parametri
dimensiuniBloc = [36, 50, 72, 90];
optiuni = cell(3,1);
optiuni{1} = 'blocuriAleatoare';
optiuni{2} = 'eroareSuprapunere';
optiuni{3} = 'frontieraCostMinim';

for idxOptiune = 1:length(optiuni)
    for idxDim = 1:length(dimensiuniBloc);
        parametri.texturaInitiala = img;
        parametri.dimensiuneTexturaSintetizata = [2*size(img,1) 2*size(img,2)];
        parametri.dimensiuneBloc = dimensiuniBloc(idxDim);

        parametri.nrBlocuri = 2000;
        parametri.eroareTolerata = 0.1;
        parametri.portiuneSuprapunere = 1/6;
        parametri.metodaSinteza = optiuni{idxOptiune};

        imgSintetizata = realizeazaSintezaTexturii(parametri);
        
        imwrite(imgSintetizata, ['../resultsSinteza/' imgName optiuni{idxOptiune} int2str(dimensiuniBloc(idxDim)) imgFmt]); 
        close all;
    end
end
close all;