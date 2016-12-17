function eticheta = clasificaSVM( histograme_test, histogrameBOVW_exemplePozitive, histogrameBOVW_exempleNegative)
% eticheta = eticheta dedusa folosind un SVM liniar: http://www.vlfeat.org/matlab/vl_svmtrain.html
%
% Input: 
%       histogramaBOVW_test - matrice 1 x K, histograma BOVW a unei imagini test
%       histogrameBOVW_exemplePozitive - matrice #ImaginiExemplePozitive x K, fiecare linie reprezinta histograma BOVW a unei imagini pozitive
%       histogrameBOVW_exempleNegative - matrice #ImaginiExempleNegative x K, fiecare linie reprezinta histograma BOVW a unei imagini negative
% Output: 
%     eticheta - eticheta dedusa a imaginii test

etichete_poz = ones(1, size(histogrameBOVW_exemplePozitive,1));
etichete_neg = zeros(1, size(histogrameBOVW_exemplePozitive,1)) - 1;

etichete = [etichete_poz etichete_neg];

histograme = [histogrameBOVW_exemplePozitive; histogrameBOVW_exempleNegative];
histograme = histograme';

[W, B, INFO] = vl_svmtrain(histograme, etichete, 0.1);

score = W'*(histograme_test')+B;

if score >= 0.5
    eticheta = 1;
else
    eticheta = 0;
end
end