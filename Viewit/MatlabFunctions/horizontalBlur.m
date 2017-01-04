function [ resultPath ] = horizontalBlur( filepath, filename, username)
    image = imread(filepath);

    rands = getRandomString(3);
    
    blurFilter = ones(1,16)./16;
    
    resultImg = imfilter(image, blurFilter, 'same', 'replicate');
    
    cd(['../Images/' username]);
    
    imwrite(resultImg, ['horizblur' rands filename]);
    
    resultPath = ['horizblur' rands filename ];
end

