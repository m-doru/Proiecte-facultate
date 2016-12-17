function histogramaBOVW = calculeazaHistogramaBOVW(descriptoriHOG, cuvinteVizuale)
  % calculeaza histograma BOVW pe baza descriptorilor si a cuvintelor
  % vizuale, gasind pentru fiecare descriptor cuvantul vizual cel mai
  % apropiat (in sensul distantei Euclidiene)
  %
  % Input:
  %   descriptori: matrice MxD, contine M descriptori de dimensiune D
  %   cuvinteVizuale: matrice NxD, contine N centri de dimensiune D 
  % Output:
  %   histogramaBOVW: vector linie 1xN 
  
 % completati codul
    m = size(descriptoriHOG, 1);
    d = size(descriptoriHOG, 2);
    n = size(cuvinteVizuale, 1);
    histogramaBOVW = zeros(1, n);
    for i = 1:m
        descriptor = descriptoriHOG(i, :);
        distante = zeros(1, n);
        for j = 1:n
            distante(j) = norm(descriptor-cuvinteVizuale(j,:));
        end
        [~, minIdx] = min(distante);
        histogramaBOVW(minIdx) = histogramaBOVW(minIdx) + 1;
    end
end