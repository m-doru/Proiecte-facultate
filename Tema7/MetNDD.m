function polinom = MetNDD(f,a,b,n,x)
    Q = zeros(n+1);
    pct = ObtinePuncteInterpolare(a,b,n);
    for i = 1:n+1
        Q(i,1) = f(pct(i));
    end
    for j = 2:n+1
        for i = j:n+1
            Q(i,j) = (Q(i,j-1)-Q(i-1,j-1))/(pct(i)-pct(i-j+1));
        end
    end
    polinom = Q(1,1);
    for k = 2:n+1
        prod = 1;
        for i = 1:k-1
            prod = prod * (x-pct(i));
        end
        prod = prod * Q(k,k);
        polinom = polinom + prod;
    end
end