function spline = SplineCubic(f, fd, a, b, n, val)
    x = zeros(1,n+1);
    x(1) = a;
    h = (b-a)/n;
    for i = 2:n+1
        x(i) = x(i-1)+h;
    end
    asociata = eye(n+1, n+1);
    for j = 2:n
        asociata(j, j-1) = 1;
        asociata(j, j) = 4;
        asociata(j, j+1) = 1;
    end
    libera = zeros(n+1, 1);
    libera(1) = fd(x(1));
    for j = 2:n
        libera(j, 1) = (3/h) * (f(x(j+1))-f(x(j-1)));
    end
    libera(n+1) = fd(x(n+1));
    
    a = zeros(1,n);
    b = asociata\libera;
    
    c = zeros(1,n);
    d = zeros(1,n);
    
    for j = 1:n
        a(j) = f(x(j));
        c(j) = -(b(j+1) - 2 * b(j))/h + 3 * (f(x(j+1)) - f(x(j)))/h^2;
        d(j) = (b(j) + b(j+1))/h^2 - 2 * (f(x(j+1)) - f(x(j)))/h^3;
    end
    
    spline = 0;
    for j = 1:n
        if ((val >= x(j)) && (val <= x(j+1)))
            spline = a(j) + b(j)*(val - x(j)) +...
                            c(j)*(val-x(j))^2 + d(j)*(val - x(j))^3;
        end
    end
end