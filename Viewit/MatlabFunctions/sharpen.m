function [ resultPath ] = sharpen( filepath, filename, username )
    image = imread(filepath);
    
    rands = getRandomString(3);
    
    resultImg = imsharpen(image);
    
    cd(['../Images/' username]);
    
    imwrite(resultImg, ['sharpen' rands filename]);
    
    resultPath = ['sharpen' rands filename ];
end

