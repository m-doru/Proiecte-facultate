function [ y ] = MetNaiva( f, a, b, n, x )
    puncte = ObtinePuncteInterpolare(a,b,n);
    polinom = 0;
    for i = 1:n+1
        polinom = polinom + puncte(i)*x^(i-1);
    end
    y = polinom;
end

