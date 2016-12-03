%citeste imaginea
imgName = 'batman';
imgFmt = '.jpg';
textureName = 'brick';
textureFmt = '.jpg';
img = imread(['../data/' textureName textureFmt]);
imgDest = imread(['../data/' imgName imgFmt]);
i = 1;
n = 5;
imgSintetizata = img;
dimBloc = 70;
for i = 1:n
    %seteaza parametri
    parametri.texturaInitiala = imgSintetizata;
    parametri.imagineDestinatie = imgDest;
    % parametri.dimensiuneTexturaSintetizata = [2*size(img,1) 2*size(img,2)];
    parametri.dimensiuneBloc = dimBloc;

    parametri.nrBlocuri = 2000;
    parametri.tradeoff = 0.8 * (i-1)/(n-1)+0.1;
    parametri.eroareTolerata = 0.1;
    parametri.portiuneSuprapunere = 1/6;

    imgSintetizata = realizeazaTransferulTexturii(parametri);
    imwrite(imgSintetizata, ['../results/' imgName textureName int2str(i) imgFmt]);
    dimBloc = dimBloc - floor(dimBloc/3);
end