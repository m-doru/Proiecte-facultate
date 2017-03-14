function [ redimLinii, redimColoane ] = obtineDimensiuniRedimensionare( img , expandScale, reduceScale)
    redimLinii = zeros(0,1);
    redimColoane = zeros(0,1);
    redimLinii(1) = size(img, 1);
    redimColoane(1) = size(img, 2);
    
    for i = 2:5
        redimLinii(i) = ceil(redimLinii(i-1)*expandScale);
        redimColoane(i) = ceil(redimColoane(i-1)*expandScale);
    end
    
    redimLinii(6) = ceil(redimLinii(1)*reduceScale);
    redimColoane(6) = ceil(redimColoane(1)*reduceScale);
    i = 6;
    
    while redimLinii(i) > 45 && redimColoane(i) > 45
        redimLinii(i+1) = ceil(redimLinii(i) * reduceScale);
        redimColoane(i+1) = ceil(redimColoane(i) * reduceScale);
        i = i + 1;
    end
end
