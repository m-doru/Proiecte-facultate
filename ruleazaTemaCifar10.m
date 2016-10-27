if ~(any(strcmp(who,'categorizedImages')))
    categorizedImages = loadClasificatedData;
end
% [32 32 3 6000 11]

displaySample = 0;
if displaySample
    figure;
    title('Cate 10 imagini din fiecare categorie');
    idxImg = 0;
    for i = 1:10
       for j = 1:10
           idxImg = idxImg + 1;
           subplot(10, 10, idxImg);
           imshow(categorizedImages(:,:,:,j,i));
       end
    end
end
classNameToId = containers.Map({'plane', 'car', 'bird', 'cat', 'deer', 'dog', 'frog', 'horse', 'boat', 'truck'}, 1:10);

director = '../data/cifar10ImgRef/';
numarPieseMozaicOrizontala = 100;
criterii = cell(2,1);
criterii{1} = 'distantaCuloareMedie';
criterii{2} = 'distantaCulori';

extensii = {'.png', '.jpg', '.jpeg', '.gif', '.img'};
filelist = dir(director);

for idxImg = 3:length(filelist)
    for idxExtensie = 1:length(extensii)
        if strendswith(filelist(idxImg).name, extensii{idxExtensie})
            class = strrep(filelist(idxImg).name, extensii{idxExtensie}, '');
        end
    end
    disp(class);
   
   for idxCriteriu = 1:length(criterii)
       imgName = filelist(idxImg).name;
       params.imgReferinta = imread([director imgName]);
       params.numeDirector = '';
       params.tipImagine = '';
       params.numarPieseMozaicOrizontala = numarPieseMozaicOrizontala;
       params.afiseazaPieseMozaic = 0;
       params.criteriu = criterii{idxCriteriu};
       params.pieseMozaic = categorizedImages(:,:,:,:,classNameToId(class));
       imgMozaic = construiesteMozaic(params);
       figure, imshow(imgMozaic);
       
       imwrite(imgMozaic,['./JPGsCifar10/mozaic' criterii{idxCriteriu} filelist(idxImg).name]);
   end
end