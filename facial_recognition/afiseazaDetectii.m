function afiseazaDetectii(detectii, img)
    for i = 1:size(detectii, 1)
        xmin = detectii(i,1);
        xmax = detectii(i,3);
        ymin = detectii(i, 2);
        ymax = detectii(i, 4);
        patch = img(ymin:ymax, xmin:xmax, :);
        figure, imshow(patch);
    end
end