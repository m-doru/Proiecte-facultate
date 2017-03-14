function E = calculeazaEnergie(img)
%calculeaza energia la fiecare pixel pe baza gradientului
%input: img - imaginea initiala
%output: E - energia

%urmati urmatorii pasi:
%transformati imaginea in grayscale
%folositi un filtru sobel pentru a calcula gradientul in directia x si y
%calculati magnitudiena gradientului
%E - energia = gradientul imaginii

%completati aici codul vostru

grayImg = rgb2gray(img);
ysobel = fspecial('sobel');
xsobel = ysobel';

xgradient = imfilter(double(grayImg), xsobel);
ygradient = imfilter(double(grayImg), ysobel);

E = sqrt((xgradient.^2)) + sqrt((ygradient.^2));

end