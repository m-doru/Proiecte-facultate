% acest script creste numarul de exemple pozitive aplicand diferite
% transformari asupra lor
imgFiles = dir( fullfile( parametri.numeDirectorExemplePozitive, '*.jpg') ); 
numarImagini = length(imgFiles);

for idx = 1:numarImagini
    disp(['Procesam exemplul pozitiv numarul ' num2str(idx)]);
    img = imread([parametri.numeDirectorExemplePozitive '/' imgFiles(idx).name]);
    imgMirror = flip(img, 2);
    imwrite(imgMirror, [parametri.numeDirectorExemplePozitive '/' '2' imgFiles(idx).name]);
end

nrImg = floor(numarImagini/2);

for idx = 1:nrImg
    disp(['Procesam exemplul pozitiv numarul ' num2str(idx)]);
    img = imread([parametri.numeDirectorExemplePozitive '/' imgFiles(idx).name]);
    imgRotita = imrotate(img, 15, 'bilinear', 'crop');
    imwrite(imgRotita, [parametri.numeDirectorExemplePozitive '/' '3' imgFiles(idx).name]);
end

for idx = nrImg+1:numarImagini
    disp(['Procesam exemplul pozitiv numarul ' num2str(idx)]);
    img = imread([parametri.numeDirectorExemplePozitive '/' imgFiles(idx).name]);
    imgRotita = imrotate(img, -15, 'bilinear', 'crop');
    imwrite(imgRotita, [parametri.numeDirectorExemplePozitive '/' '4' imgFiles(idx).name]);
end