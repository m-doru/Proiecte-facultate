function [t, x] = MidPoint(f, a ,b, alfa, N)
  t = zeros(N+1, 1);
  t(1) = a;
  h = (b-a)/N;
  for i = 2:N+1
    t(i) = t(i-1) + h;
  end
  x = zeros(size(alfa, 1), N+1);
  x(:,1) = alfa;
  for i = 1:N
    K1 = h*f(t(i), x(:,i));
    K2 = h*f(t(i) + h/2, x(:,i) + K1/2);
    x(:,i+1) = x(:,i) + K2;
  end
end