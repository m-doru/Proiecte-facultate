director = {'./JPGs', '../data/imaginiTest', '../data/imaginiTestAlegere'};
%director = '../data/imaginiTest';
%director = '../data/imaginiTestAlegere';

for idxDir = 1:length(director)
    mozaicuri = [dir([director{idxDir} '/*.' 'jpeg']); dir([director{idxDir} '/*.' 'JPG']); dir([director{idxDir} '/*.' 'png'])];
    for idx = 1:length(mozaicuri)
        imgNm = [director{idxDir} '/' mozaicuri(idx).name];
        img = imread(imgNm);
        mozaic = figure;
        imshow(img);
        export_fig(['PDFs/' mozaicuri(idx).name], mozaic, '-pdf');
    end
end