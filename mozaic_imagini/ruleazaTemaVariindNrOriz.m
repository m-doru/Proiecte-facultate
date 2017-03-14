filelist = [dir(['../data/imaginiTest' '/*.' 'jpeg']); dir([ '../data/imaginiTest' '/*.' 'JPG'])];
criterii = cell(2,1);
criterii{1} = 'distantaCuloareMedie';
criterii{2} = 'distantaCulori';
for nrPieseOrizontala = [10 25 50 75 100]
    for idxCriteriu = 2rul:length(criterii)
        for idxImg = 1:length(filelist)-2
            imgName = ['../data/imaginiTest' '/' filelist(idxImg).name];

            disp(['Working on ' imgName ' with ' int2str(nrPieseOrizontala) ' piese pe orizontala pe cazul ' criterii{idxCriteriu}]);
            
            imgMozaic = computeMozaic(imgName, [pwd '/../data/colectie/'],...
                'png', criterii{idxCriteriu}, nrPieseOrizontala,0);
            imwrite(imgMozaic,['./JPGsVariindNrOriz/mozaic' criterii{idxCriteriu} int2str(nrPieseOrizontala) 'Oriz' filelist(idxImg).name]);
            %mozaic = figure, imshow(imgMozaic);
        end
    end
end