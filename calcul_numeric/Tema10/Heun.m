function [t, x] = Heun(f, a, b, alfa, N)
  t = zeros(1,N+1);
  t(1) = a;
  h = (b-a)/N;
  for i = 2:N+1
    t(i) = t(i-1) + h;
  end
  x = zeros(size(alfa, 1), N+1);
  x(:,1) = alfa;
  for i = 1:N
    K1 = h * f(t(i), x(:,i));
    K2 = h * f(t(i) + 2/3*h, x(:,i) + 2/3 * K1);
    x(:,i+1) = x(:,i) + 1/4 * (K1 + 3*K2);
  end  
end