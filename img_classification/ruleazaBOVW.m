%
% Tema 4 - Clasificarea Imaginilor folosind modelul Bag-of-Visual-Words
% 
%
%%
%ANTRENARE
kvalues = [5 10 25 50 100 200 500 1000];
fileID = fopen('results.txt','w');
for i = 1:length(kvalues)
    disp('Etapa de antrenare');
    disp('Construim vocabularul de cuvinte vizuale');

    k = kvalues(i);% k = numarul de cuvinte vizuale ale vocabularului
    iterMax = 50;

    % cuvintele vizuale sunt centri clusterilor obtinuti prin k-means
    % se obtin prin apelarea functiei construiesteVocabular
    cuvinteVizuale = construiesteVocabular('../data/masini-exempleAntrenare-pozitive+negative',k,iterMax);
    % 
    disp('Procesam imaginile de antrenare pozitive (contin masini)');
    histogrameBOVW_exemplePozitive = calculeazaHistogrameBOVW_director('../data/masini-exempleAntrenare-pozitive',cuvinteVizuale);
    disp('Procesam imaginile de antrenare negative (NU contin masini)');
    histogrameBOVW_exempleNegative = calculeazaHistogrameBOVW_director('../data/masini-exempleAntrenare-negative',cuvinteVizuale);

    %%
    %TESTARE
    disp('Etapa de testare');
    disp('Procesam imaginile de testare pozitive (contin masini)');
    histogrameBOVW_exemplePozitive_test = calculeazaHistogrameBOVW_director('../data/masini-exempleTestare-pozitive',cuvinteVizuale);
    disp('Procesam imaginile de testare negative (NU contin masini)');
    histogrameBOVW_exempleNegative_test = calculeazaHistogrameBOVW_director('../data/masini-exempleTestare-negative',cuvinteVizuale);

    nrExemplePozitive = size(histogrameBOVW_exemplePozitive_test,1);
    nrExempleNegative = size(histogrameBOVW_exempleNegative_test,1);

    histogrameBOVW_test = [histogrameBOVW_exemplePozitive_test;histogrameBOVW_exempleNegative_test];
    etichete_test = [ones(nrExemplePozitive,1);zeros(nrExempleNegative,1)];

    disp('______________________________________')
    disp('Clasificator Cel Mai Apropiat Vecin')
    celMaiApropiatVecin = clasificaBOVW(histogrameBOVW_test, etichete_test, histogrameBOVW_exemplePozitive, histogrameBOVW_exempleNegative, @clasificaBOVWCelMaiApropiatVecin);
    disp('______________________________________')
    disp('Clasificator SVM linear')
    svm = clasificaBOVW(histogrameBOVW_test, etichete_test, histogrameBOVW_exemplePozitive, histogrameBOVW_exempleNegative, @clasificaSVM);
    disp('______________________________________')
    
    fprintf(fileID, '%d cmap %f svm %f\r\n', k,celMaiApropiatVecin, svm);
end

fclose(fileID);