% director = {'./JPGs', '../data/imaginiTest', '../data/imaginiTestAlegere'};
%director = '../data/imaginiTest';
%director = '../data/imaginiTestAlegere';
sourceDirector = {'../data/cifar10ImgRef'};
destinationDirector = {'PDFsCifar10/'};

for idxDir = 1:length(sourceDirector)
    mozaicuri = [dir([sourceDirector{idxDir} '/*.' 'jpeg']); dir([sourceDirector{idxDir} '/*.' 'JPG']); dir([sourceDirector{idxDir} '/*.' 'png'])];
    for idx = 1:length(mozaicuri)
        imgNm = [sourceDirector{idxDir} '/' mozaicuri(idx).name];
        img = imread(imgNm);
        mozaic = figure;
        imshow(img);
        export_fig([destinationDirector{1} mozaicuri(idx).name], mozaic, '-pdf');
    end
end