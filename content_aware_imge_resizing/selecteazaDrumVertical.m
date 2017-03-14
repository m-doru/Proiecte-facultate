function d = selecteazaDrumVertical(E,metodaSelectareDrum)
%selecteaza drumul vertical ce minimizeaza functia cost calculate pe baza lui E
%
%input: E - energia la fiecare pixel calculata pe baza gradientului
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%
%output: d - drumul vertical ales

d = zeros(size(E,1),2);

switch metodaSelectareDrum
    case 'aleator'
        %pentru linia 1 alegem primul pixel in mod aleator
        linia = 1;
        %coloana o alegem intre 1 si size(E,2)
        coloana = randi(size(E,2));
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            %alege urmatorul pixel pe baza vecinilor
            %linia este i
            linia = i;
            %coloana depinde de coloana pixelului anterior
            if d(i-1,2) == 1%pixelul este localizat la marginea din stanga
                %doua optiuni
                optiune = randi(2)-1;%genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                %doua optiuni
                optiune = randi(2) - 2; %genereaza -1 sau 0
            else
                optiune = randi(3)-2; % genereaza -1, 0 sau 1
            end
            coloana = d(i-1,2) + optiune;%adun -1 sau 0 sau 1: 
                                         % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end
    case 'greedy'
        %completati aici codul vostru
        linia = 1;
        %alegem pixelul de valoare minima de pe linia 1
        [~, coloana] = min(E(1,:));
        d(1, :) = [linia coloana];
        for i = 2:size(d, 1)
            linia = i;
            switch d(i-1, 2)
                case 1
                    [~, optiune] = min(E(i, 1:2));
                    optiune = optiune - 1;
                case size(E, 2)
                    [~, optiune] = min(E(i, size(E,2)-1:size(E,2)));
                    optiune = optiune - 2;
                otherwise
                    [~, optiune] = min(E(i, d(i-1,2)-1:d(i-1, 2)+1));
                    optiune = optiune - 2;
            end
            coloana = d(i-1, 2) + optiune;
            d(i,:) = [linia coloana];
        end
    case 'programareDinamica'
        %completati aici codul vostru
        D = double(zeros(size(E)));
        nrColoane = size(E, 2);
        nrLinii = size(E, 1);
        %construim dinamica sus in jos si de la stanga la dreapta
        %pentru prima linie valorile sunt cele din gradient
        D(1,:) = E(1, :);
        %pentru restul liniilor, se aduna valoarea pixelului curent cu
        %valoarea minima ca celor 3 pixeli de deasupra lui, in cazul in
        %care exista
        for i = 2:nrLinii
            D(i, 1) = E(i,1) + min(D(i-1, 1:2));
            for j = 2:nrColoane-1
                D(i,j) = E(i,j) + min(D(i-1, j-1:j+1));
            end
            D(i, nrColoane) = E(i, nrColoane) + min(D(i-1, nrColoane-1:nrColoane));
        end
        
        %construim drumul de jos in sus
        linia = nrLinii;
        [~, coloana] = min(D(nrLinii, :));
        d(nrLinii,:) = [linia coloana];
        for i = nrLinii-1:-1:1
            linia = i;
            switch d(i+1, 2)
                case 1
                    [~, optiune] = min(D(linia, 1:2));
                    optiune = optiune - 1;
                case nrColoane
                    [~, optiune] = min(D(linia, nrColoane-1:nrColoane));
                    optiune = optiune - 2;
                otherwise
                    [~, optiune] = min(D(linia, d(i+1,2)-1:d(i+1,2)+1));
                    optiune = optiune - 2;
            end
            coloana = d(i+1, 2) + optiune;
            d(linia, :) = [linia coloana];
        end
    otherwise
        error('Optiune pentru metodaSelectareDrum invalida');
end

end