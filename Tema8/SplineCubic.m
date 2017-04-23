function spline = SplineCubic(f, fd, a, b, n, val)
    x = zeros(1,n+1);
    x(1) = a;
    h = (b-a)/n;
    for i = 2:n+1
        x(i) = x(i-1)+h;
    end
    asociata = ones(n-1, 3) .* [1 4 1];
    libera = zeros(n-1, 1);
    for j = 2:n
        libera(j-1, 1) = (3/h) * (functie(x(j+1))-functie(x(j-1)));
    end
    
    bcalc = inv(asociata)*libera;
    
    a = zeros(1,n);
    b = zeros(1,n+1);
    b(1) = fd(x(1));
    b(2:n) = bcalc;
    b(n+1) = fd(x(n+1));
    
    c = zeros(1,n);
    d = zeros(1,n);
    
    for j = 1:n
        a(j) = f(x(j));
        c(j) = -(b(j+1) - 2 * b(j))/h + 3 * (f(x(j+1)) - f(x(j)))/h^2;
        d(j) = (b(j) + b(j+1))/h^2 - 2 * (f(x(j+1)) - f(x(j)))/h^3;
    end
    
    spline = 0;
    for i = 1:n
        if val >= x(j) && val <= x(j+1)
            spline = a(j) + b(j)*(val - x(j)) +...
                            c(j)*(val-x(j))^2 + d(j)*(val - x(j))^3;
        end
    end
end