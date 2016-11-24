function drum = determinaDrumCostMinim(eroare)
    
    D = double(zeros(size(eroare)));
    
    D(1, :) = eroare(1,:);
    nrColoane = size(eroare,2);
    
    for i = 2:size(eroare, 1)
        D(i,1) = min([D(i-1, 1) D(i-1,2)]) + eroare(i, 1);
        for j = 2:nrColoane-1
            D(i,j) = min([D(i-1,j-1) D(i-1,j) D(i-1,j+1)]) + eroare(i,j);
        end
        D(i, nrColoane) = min([D(i-1, nrColoane-1) D(i-1,nrColoane)]) +...
            eroare(i,nrColoane);
    end
    
    drum = zeros(size(eroare,1), 2);
    [~, coloana] = min(D(size(D,1), :));
    
    drum(size(drum,1), :) = [size(drum,1), coloana];
    for i = size(drum,1)-1:-1:1
        linia = i;
        coloana = drum(linia+1, 2);
        if drum(linia+1, 2) == 1
            [~, optiune] = min([D(linia, 1) D(linia, 2)]);
            optiune = optiune - 1;
        else
            if drum(linia+1, 2) == size(eroare,2)
                [~, optiune] = min([D(linia, size(D, 2))...
                                    D(linia, size(D,2)-1)]);
                optiune = optiune - 2;
            else
                [~, optiune] = min([D(linia, coloana-1)...
                                D(linia, coloana) D(linia, coloana+1)]);
                optiune = optiune - 2;
            end
        end
        drum(i,:) = [linia, coloana+optiune];
    end

end