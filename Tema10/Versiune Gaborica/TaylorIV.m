function [ t, x ] = TaylorIV( f, df, d2f, d3f, a, b, alfa, N )
    h = (b-a)/N;
    t = zeros(1,N+1);
    t(1) = a;
    for i = 2:N+1
       t(i) = t(i-1)+h; 
    end
    x = zeros(size(alfa,1),N);
    x(:,1) = alfa;
    for i = 1:N
       sum = 0;
       %k = 1
       sum = sum + f(t(i),x(:,i));
       %k = 2
       sum = sum + ((h/2) * df(t(i),x(:,i)));
       %k = 3
       sum = sum + ((h^2/6) * d2f(t(i),x(:,i)));
       %k = 4
       sum = sum + ((h^3/24) * d3f(t(i),x(:,i)));
       x(:,i+1) = x(:,i) + h * sum;
    end
end

