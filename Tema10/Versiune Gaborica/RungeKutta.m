function [ t, x ] = RungeKutta( f,a,b,alfa,N)
    h = (b-a)/N;
    t = zeros(1,N+1);
    t(1) = a;
    for i = 2:N+1
        t(i) = t(i-1) + h;
    end
    x = zeros(size(alfa,1),N);
    x(:,1) = alfa;
    for i = 1:N
       K1 = h * f(t(i), x(:,i));
       K2 = h * f(t(i)+(h/2), x(:,i) + (K1/2));
       K3 = h * f(t(i)+(h/2), x(:,i) + (K2/2));
       K4 = h * f(t(i)+h, x(:,i) + K3);
       x(:,i+1) = x(:,i) + (1/6)*(K1 + 2*K2 + 2*K3 + K4);
    end
end

