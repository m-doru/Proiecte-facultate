function [ t, x ] = TaylorII( f, df, a, b, alfa, N )
    h = (b-a)/N;
    t = zeros(1,N+1);
    t(1) = a;
    for i = 2:N+1
        t(i) = t(i-1) + h;
    end
    x = zeros(1,N);
    x(1) = alfa;
    for i = 1:N
       sum = 0;
       %k = 1
       sum = sum + f(t(i),x(i));
       %k = 2
       sum = sum + ((h/2) * df(t(i),x(i)));
       x(i+1) = x(i) + h * sum;
    end
end

