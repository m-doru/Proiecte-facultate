a = 0;
b = 3;
N = 200;
A = [1 2; 2 1];
bval = [1; 2];
alfa = [3;2];
f = @(t, x)A * x + bval;
solf = @(t)[3*exp(3*t)+exp(-t)-1;3*exp(3*t)-exp(-t)];


[t,x] = RungeKutta(f, a, b, alfa, N);
figure;
real_vals = solf(t);
diff = x - real_vals;
plot(t, sqrt(sum(diff.^2, 1)), 'r');
title('Eroare la runge kutta');
saveas(gcf, '2xeroare_runge_kutta.jpg', 'jpg');


[t,x] = Euler(f, a, b, alfa, N);
figure;
real_vals = solf(t);
diff = x - real_vals;
plot(t, sqrt(sum(diff.^2, 1)), 'r');
title('Eroare la Euler');
saveas(gcf, '2xEroare_euler.jpg', 'jpg');

[t,x] = Eulermod(f, a, b, alfa, N);
figure;
real_vals = solf(t);
diff = x - real_vals;
plot(t, sqrt(sum(diff.^2, 1)), 'r');
title('Eroare la Eulermod');
saveas(gcf, '2xeroare_euler_mod.jpg', 'jpg');

[t,x] = MidPoint(f, a, b, alfa, N);
figure;
real_vals = solf(t);
diff = x - real_vals;
plot(t, sqrt(sum(diff.^2, 1)), 'r');
title('Eroare la MidPoint');
saveas(gcf, '2xeroare_midpoint.jpg', 'jpg');

[t,x] = Heun(f, a, b, alfa, N);
figure;
real_vals = solf(t);
diff = x - real_vals;
plot(t, sqrt(sum(diff.^2, 1)), 'r');
title('Eroare la Heun');
saveas(gcf, '2xeroare_heun.jpg', 'jpg');
