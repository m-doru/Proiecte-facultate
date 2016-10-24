director = './JPGs';
%director = '../data/imaginiTest';
%director = '../data/imaginiTestAlegere';

%mozaicuri = [dir([director '/*.' 'jpeg']); dir([director '/*.' 'JPG']); dir([director '/*.' 'png'])];
mozaicuri = dir([director '/*.' 'png']);

for idx = 1:length(mozaicuri)
    imgNm = [director '/' mozaicuri(idx).name];
    img = imread(imgNm);
    mozaic = figure;
    imshow(img);
    export_fig(['PDFs/' mozaicuri(idx).name], mozaic, '-pdf');
end