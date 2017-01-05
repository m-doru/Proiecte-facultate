function [ redimLinii, redimColoane ] = obtineDimensiuniRedimensionare( img , expandScale, reduceScale)
    redimLinii = zeros(0,1);
    redimColoane = zeros(0,1);
    redimLinii(1) = size(img, 1);
    redimColoane(1) = size(img, 2);
    
    for i = 2:5
        redimLinii(i) = ceil(redimLinii(i-1)*expandScale);
        redimColoane(i) = ceil(redimColoane(i-1)*expandScale);
    end
    
    tempLinii = zeros(4, 1);
    tempColoane = zeros(4, 1);
    
    tempLinii(1) = floor(redimLinii(1)*reduceScale);
    tempColoane(1) = floor(redimColoane(1)*reduceScale);
    
    for i = 2:4
        tempLinii(i) = floor(tempLinii(i-1)*reduceScale);
        tempColoane(i) = floor(tempColoane(i-1)*reduceScale);
    end
    idx = 6;
    for i = 1:4
       if tempLinii(i) > 50 && tempColoane(i) > 50
           redimLinii(idx) = tempLinii(i);
           redimColoane(idx) = tempColoane(i);
           idx = idx + 1;
       end
    end

end
