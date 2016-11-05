function d = selecteazaDrumOrizontal( E, metodaSelectareDrum )
d = zeros(size(E, 2), 2);

nrLinii = size(E, 1);
nrColoane = size(E, 2);

switch metodaSelectareDrum
    case 'aleator'
        coloana = 1;
        linia = randi(nrLinii);
        d(1,:) = [linia coloana];
        for i = 2:nrColoane
            coloana = i;
            switch d(coloana - 1, 1)
                case 1
                    optiune = randi(2) - 1;
                case nrLinii
                    optiune = randi(2) - 2;
                otherwise
                    optiune = randi(3) - 2;
            end
            linia = d(coloana - 1, 1) + optiune;
            d(i, :) = [linia coloana];
        end
    case 'greedy'
        coloana = 1;
        [~, linia] = min(E(:, 1));
        d(1,:) = [linia coloana];
        
        for i = 2:nrColoane
            coloana = i
            switch d(coloana - 1, 1)
                case 1
                    [~, optiune] = min(E(1:2, i));
                    optiune = optiune - 1;
                case nrLinii
                    [~, optiune] = min(E(nrLinii-1:nrLinii, i));
                    optiune = optiune - 2;
                otherwise
                    [~, optiune] = min(E(d(i-1,1)-1:d(i-1,1)+1,i));
            end
            linia = d(i-1, 1) + optiune;
            d(i, :) = [linia coloana];
        end
    case 'programareDinamica'
        

end






