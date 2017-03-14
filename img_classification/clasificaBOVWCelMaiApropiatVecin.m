function eticheta = clasificaBOVWCelMaiApropiatVecin(histogramaBOVW_test,histogrameBOVW_exemplePozitive,histogrameBOVW_exempleNegative)
% eticheta = eticheta celui mai apropiat vecin (in sensul distantei Euclidiene)
% eticheta = 1, daca cel mai apropiat vecin este un exemplu pozitiv,
% eticheta = 0, daca cel mai apropiat vecin este un exemplu negativ. 
% Input: 
%       histogramaBOVW_test - matrice 1 x K, histograma BOVW a unei imagini test
%       histogrameBOVW_exemplePozitive - matrice #ImaginiExemplePozitive x K, fiecare linie reprezinta histograma BOVW a unei imagini pozitive
%       histogrameBOVW_exempleNegative - matrice #ImaginiExempleNegative x K, fiecare linie reprezinta histograma BOVW a unei imagini negative
% Output: 
%     eticheta - eticheta dedusa a imaginii test

  
% completati codul
k = size(histogrameBOVW_exemplePozitive, 1);
distante_pozitive = zeros(1,k);
distante_negative = zeros(1,k);
for i = 1:k
    distante_pozitive(i) = norm(histogramaBOVW_test-histogrameBOVW_exemplePozitive(i, :));
    distante_negative(i) = norm(histogramaBOVW_test-histogrameBOVW_exempleNegative(i, :));
end

min_poz = min(distante_pozitive);
min_neg = min(distante_negative);
if min_poz <= min_neg
    eticheta = 1;
else
    eticheta = 0;
end
end
