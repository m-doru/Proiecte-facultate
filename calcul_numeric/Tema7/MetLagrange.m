function polinom = MetLagrange(f, a, b, n, x)
    noduriInterpolare = ObtinePuncteInterpolare(a,b,n);
    y = f(noduriInterpolare);
    polinom = 0;
    for k = 1:n+1
        polinom = polinom + FunctieDeBaza(n,k,x,noduriInterpolare)*y(k);
    end
end

function rez = FunctieDeBaza(n,k,x, noduriInterpolare)
    numarator = 1;
    numitor = 1;
    for i = 1:n+1
        if i ~= k
            numarator = numarator * (x-noduriInterpolare(i));
            numitor = numitor * (noduriInterpolare(k)-noduriInterpolare(i));
        end
    end
    rez = numarator/numitor;
end