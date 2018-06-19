function [t, x] = TaylorII(f, df,a, b, alfa, N)
  t = zeros(N+1, 1);
  t(1) = a;
  h = (b-a)/N;
  for i = 2:N+1
    t(i) = t(i-1) + h;
  end
  x = zeros(N+1, 1);
  x(1) = alfa;
  for i = 1:N
      x(i+1) = x(i) + h * (f(t(i), x(i)) + h/2 * df(t(i), x(i)));
  end
end