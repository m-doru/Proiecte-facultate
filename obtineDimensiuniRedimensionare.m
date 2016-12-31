% function [ redimLinii, redimColoane ] = obtineDimensiuniRedimensionare( img )
%     redimLinii = zeros(0,1);
%     redimColoane = zeros(0,1);
%     redimLinii(1) = size(img, 1);
%     redimColoane(1) = size(img, 2);
% 
%     for i = 2:4
%         redimLinii(i) = redimLinii(1)*i;
%         redimColoane(i) = redimColoane(1)*i;
%     end
%     
%     idx = 5;
%     
%     difLinii = size(img, 1) - 36;
%     difColoane = size(img, 2) - 36;
%     
%     for i = 1:3
%         redimLinii(idx) = floor(size(img, 1) - difLinii * i/3);
%         redimColoane(idx) = floor(size(img, 2) - difColoane * i/3);
%         idx = idx+1;
%     end
%     
% end


function [ redimLinii, redimColoane ] = obtineDimensiuniRedimensionare( img , expandScale, reduceScale)
    redimLinii = zeros(0,1);
    redimColoane = zeros(0,1);
    redimLinii(1) = size(img, 1);
    redimColoane(1) = size(img, 2);
    
    for i = 2:5
        redimLinii(i) = ceil(redimLinii(i-1)*expandScale);
        redimColoane(i) = ceil(redimColoane(i-1)*expandScale);
    end
    
    
    redimLinii(6) = floor(redimLinii(1)*reduceScale);
    redimColoane(6) = floor(redimColoane(1)*reduceScale);
    
    for i = 7:9
        redimLinii(i) = floor(redimLinii(i-1)*reduceScale);
        redimColoane(i) = floor(redimColoane(i-1)*reduceScale);
    end

end
