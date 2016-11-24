function ploteazaDrum(img, drum)
    for i = 1:size(drum, 1)
        img(drum(i,1), drum(i,2), :) = [255 0 0];
    end
    figure, imshow(img);
end