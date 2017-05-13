A = [1 1 1; 2 -2 -1; 4 4 1];
bval = [3; -1; 9];
alfa = [0;0;0];
a = 0;
b = 2;
N = 200;
f = @(t, x) A * x + bval;
solf = @(t) exp(-t) + exp(2*t) + exp(-2*t);

[t, x] = RungeKutta(f, a, b, alfa, N);
aprox_values = zeros(size(t));
for i = 1:size(x,2)
  aprox_values(i) = x(1,i)*exp(2*t(i)) + x(2,i)*exp(-2*t(i)) + x(3,i)*exp(-t(i));
end
figure;
real_vals = solf(t);
diff = abs(aprox_values - real_vals);
plot(t, diff, 'r');
title('Eroare la runge kutta');
saveas(gcf, '3xeroare_runge_kutta.jpg', 'jpg');
 