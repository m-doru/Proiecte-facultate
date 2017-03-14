function [ resultPath ] = enhance( filepath, filename, username )
    image = imread(filepath);

    rands = getRandomString(3);
    
    blurFilter = ones(3,3)./4;
    
    resultImg = imfilter(image, blurFilter, 'same', 'replicate');
    
    cd(['../Images/' username]);
    
    imwrite(resultImg, ['enhanced' rands filename]);
    
    resultPath = ['enhanced' rands filename ];
end

% 7UYW9Z7MJB7c6c727a97eb4383845a12d3d7773522.jpg
% dorumus