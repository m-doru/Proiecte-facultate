function categorizedImages = loadClasificatedData
% loads the batches from cifar-10 as the following data structure
% [H, W, C, ImgNumber, Class]
filelist = [dir('../data/cifar-10-batches-mat/data*.mat');dir('../data/cifar-10-batches-mat/test_batch.mat')];

categorizedImages = uint8(zeros(32, 32, 3, 6000, 11));

k = ones(10, 1);
for i = 1:length(filelist)
    dataBatch = ['../data/cifar-10-batches-mat/' filelist(i).name];
    structData = load(dataBatch);
    
    structData.labels = uint8(structData.labels);
    
    for j = 1:size(structData.data, 1)
        categorizedImages(:,:,:, k(structData.labels(j)+1), structData.labels(j)+1) =...
            imrotate(reshape(structData.data(j, :), [32 32 3]), -90);
        k(structData.labels(j)+1) = k(structData.labels(j)+1) + 1;
    end
end
