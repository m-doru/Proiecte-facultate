function [ resultPath ] = verticalBlur( filepath, filename, username )
    image = imread(filepath);
    
    rands = getRandomString(3);
    
    blurFilter = ones(16,1)./16;
    
    resultImg = imfilter(image, blurFilter, 'same', 'replicate');
    
    cd(['../Images/' username]);
    
    imwrite(resultImg, ['vertblur' rands filename]);
    
    resultPath = ['vertblur' rands filename ];
end

