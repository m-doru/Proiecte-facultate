imgFiles = dir( fullfile( parametri.numeDirectorExemplePozitive, '*.jpg') ); 
numarImagini = length(imgFiles);

for idx = 1:numarImagini
    if imgFiles(idx).name(1) == '3' || imgFiles(idx).name(1) == '4' 
        delete(fullfile([parametri.numeDirectorExemplePozitive '/' imgFiles(idx).name]));
    end
end