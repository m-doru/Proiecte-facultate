function puncte = ObtinePuncteInterpolare(a, b, n)
    puncte = zeros(n+1);
    puncte(1) = a;
    h = (b-a)/n;
    for i = 2:n+1
        puncte(i) = puncte(i-1)+h;
    end
end