function eroare = calculeazaEroare(img1, img2)
    img1 = double(rgb2gray(img1));
    img2 = double(rgb2gray(img2));
    eroare = norm(img1 - img2);
end