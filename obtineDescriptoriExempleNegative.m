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
    
    if size(img, 1) < 150 || size(img,2) < 150
        numarExempleNegative_pe_imagineaCurenta = floor(numarExempleNegative_pe_imagine/3);
    else
        if size(img, 1) > 500 && size(img, 2) > 500
            numarExempleNegative_pe_imagineaCurenta = floor(numarExempleNegative_pe_imagine*2);
        else
            numarExempleNegative_pe_imagineaCurenta = numarExempleNegative_pe_imagine;
        end
    end
    %completati codul functiei in continuare
    
    inaltime = size(img, 1);
    latime = size(img, 2);
    
    %generam aleator puncte corespunzatoare coltului din stanga sus pentru
    %dreptunghiuri
    
    x = randi(inaltime-parametri.dimensiuneFereastra+1, [1,numarExempleNegative_pe_imagineaCurenta]);
    y = randi(latime-parametri.dimensiuneFereastra+1, [1, numarExempleNegative_pe_imagineaCurenta]);
    
    for j = 1:numarExempleNegative_pe_imagineaCurenta
        patch = img(x(j):x(j)+parametri.dimensiuneFereastra-1, y(j):y(j)+parametri.dimensiuneFereastra-1);
        descriptor = vl_hog(single(patch), parametri.dimensiuneCelulaHOG);
        descriptoriExempleNegative(idxEx, :) = descriptor(:);
        idxEx = idxEx + 1;
    end
end

end






