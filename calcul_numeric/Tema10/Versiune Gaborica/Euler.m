function [ t, x ] = Euler( f, a, b, alfa, N )
    h = (b-a)/N;
    t = zeros(1,N+1);
    t(1) = a;
    for i = 2:N+1
       t(i) = t(i-1)+h; 
    end
    x = zeros(size(alfa,1),N);
    x(:,1) = alfa;
    for i = 1:N
       x(:,i+1) = x(:,i) + h*f(t(i),x(:,i));
    end
end

