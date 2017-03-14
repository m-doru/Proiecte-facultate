function eroare = calculeazaEroare(img1, img2)
    if size(img1, 3) == 3
        img1 = rgb2gray(img1);
    end
    if size(img2, 3) == 3
        img2 = rgb2gray(img2);
    end
    img1 = double(img1);
    img2 = double(img2);
    eroare = norm(img1 - img2);
end