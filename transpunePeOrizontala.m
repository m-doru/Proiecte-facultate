function drumNou = transpunePeOrizontala( drum, nrColoane )

    drumNou = zeros(size(drum));
    for i = 1:size(drumNou, 1)
       coloana = i;
       linie = nrColoane - drum(i,2) + 1;
       drumNou(i, :) = [linie, coloana];
    end

end