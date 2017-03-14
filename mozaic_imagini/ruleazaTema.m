filelist = [dir(['../data/imaginiTest' '/*.' 'jpeg']); dir([ '../data/imaginiTest' '/*.' 'JPG'])];
criterii = cell(2,1);
criterii{1} = 'distantaCuloareMedie';
criterii{2} = 'distantaCulori';

for idxCriteriu = 1:length(criterii)
    for idxImg = 1:length(filelist)
        imgName = ['../data/imaginiTest' '/' filelist(idxImg).name];

        imgMozaic = computeMozaic(imgName, [pwd '/../data/colectie/'],...
            'png', criterii{idxCriteriu}, 100,0);
        imwrite(imgMozaic,['./JPGs/mozaic' criterii{idxCriteriu} filelist(idxImg).name]);
        %mozaic = figure, imshow(imgMozaic);
    end
end
