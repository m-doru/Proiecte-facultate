function descriptoriExempleNegative = obtineDescriptoriExempleNegative(parametri)
% descriptoriExempleNegative = matrice MxD, unde:
%   M = numarul de exemple negative de antrenare (NU sunt fete de oameni),
%   M = parametri.numarExempleNegative
%   D = numarul de dimensiuni al descriptorului
%   in mod implicit D = (parametri.dimensiuneFereastra/parametri.dimensiuneCelula)^2*parametri.dimensiuneDescriptorCelula

imgFiles = dir( fullfile( parametri.numeDirectorExempleNegative , '*.jpg' ));
numarImagini = length(imgFiles);

numarExempleNegative_pe_imagine = round(parametri.numarExempleNegative/numarImagini);
descriptoriExempleNegative = zeros(parametri.numarExempleNegative,(parametri.dimensiuneFereastra/parametri.dimensiuneCelulaHOG)^2*parametri.dimensiuneDescriptorCelula);
disp(['Exista un numar de imagini = ' num2str(numarImagini) ' ce contine numai exemple negative']);

idxEx = 1;

for idx = 1:numarImagini
    disp(['Procesam imaginea numarul ' num2str(idx)]);
    img = imread([parametri.numeDirectorExempleNegative '/' imgFiles(idx).name]);
    if size(img,3) == 3
        img = rgb2gray(img);
    end 
    %completati codul functiei in continuare
    
    inaltime = size(img, 1);
    latime = size(img, 2);
    
    %exemplele negative vor avea tot 36x36 pixeli
    %generam aleator puncte corespunzatoare coltului din stanga sus pentru
    %dreptunghiuri
    
    x = randi(inaltime-parametri.dimensiuneFereastra+1, numarExempleNegative_pe_imagine);
    y = randi(latime-parametri.dimensiuneFereastra+1, numarExempleNegative_pe_imagine);
    
    for j = 1:numarExempleNegative_pe_imagine
        patch = img(x(j):x(j)+parametri.dimensiuneFereastra-1, y(j):y(j)+parametri.dimensiuneFereastra-1);
        rez = vl_hog(single(patch), parametri.dimensiuneCelulaHOG);
        descriptoriExempleNegative(idxEx, :) = rez(:);
        idxEx = idxEx + 1;
    end
end








