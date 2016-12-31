% acest script creste numarul de exemple pozitive aplicand diferite
% transformari asupra lor
imgFiles = dir( fullfile( '../data/exempleNegative', '*.jpg') ); 
inputDir = '../data/exempleNegative';
director = '../data/exempleNegative2';
numarImagini = length(imgFiles);

% for idx = 1:numarImagini
%     disp(['Procesam exemplul pozitiv numarul ' num2str(idx)]);
%     img = imread([inputDir '/' imgFiles(idx).name]);
%     imgRotita = imrotate(img, 35, 'bilinear', 'crop');
%     imwrite(imgRotita, [director '/' '5' imgFiles(idx).name]);
% end
% 
% for idx = 1:numarImagini
%     disp(['Procesam exemplul pozitiv numarul ' num2str(idx)]);
%     img = imread([inputDir '/' imgFiles(idx).name]);
%     imgRotita = imrotate(img, -35, 'bilinear', 'crop');
%     imwrite(imgRotita, [director '/' '6' imgFiles(idx).name]);
% end

for idx = 1:numarImagini
    disp(['Procesam exemplul negativ numarul ' num2str(idx)]);
    img = imread([inputDir '/' imgFiles(idx).name]);
    imgFlip = flip(img, 2);
    imwrite(imgFlip, [director '/' '2' imgFiles(idx).name]);
end