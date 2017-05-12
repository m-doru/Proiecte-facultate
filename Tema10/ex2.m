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
pc = plot(t, abs(x(1,:) - real_vals(1,:)), 'r');
set(pc, 'linewidth', 5);
hold on;
rc = plot(t, abs(x(2,:) - real_vals(2,:)), 'y');
set(rc, 'linewidth', 1.5);
hold off;
title('Eroare la runge kutta');

[t,x] = Euler(f, a, b, alfa, N);
figure;
real_vals = solf(t);
pc = plot(t, abs(x(1,:) - real_vals(1,:)), 'r');
set(pc, 'linewidth', 5);
hold on;
rc = plot(t, abs(x(2,:) - real_vals(2,:)), 'y');
set(rc, 'linewidth', 1.5);
hold off;
title('Eroare la Euler');

[t,x] = Eulermod(f, a, b, alfa, N);
figure;
real_vals = solf(t);
pc = plot(t, abs(x(1,:) - real_vals(1,:)), 'r');
set(pc, 'linewidth', 5);
hold on;
rc = plot(t, abs(x(2,:) - real_vals(2,:)), 'y');
set(rc, 'linewidth', 1.5);
hold off;
title('Eroare la Eulermod');

[t,x] = MidPoint(f, a, b, alfa, N);
figure;
real_vals = solf(t);
pc = plot(t, abs(x(1,:) - real_vals(1,:)), 'r');
set(pc, 'linewidth', 5);
hold on;
rc = plot(t, abs(x(2,:) - real_vals(2,:)), 'y');
set(rc, 'linewidth', 1.5);
hold off;
title('Eroare la MidPoint');

[t,x] = Heun(f, a, b, alfa, N);
figure;
real_vals = solf(t);
pc = plot(t, abs(x(1,:) - real_vals(1,:)), 'r');
set(pc, 'linewidth', 5);
hold on;
rc = plot(t, abs(x(2,:) - real_vals(2,:)), 'y');
set(rc, 'linewidth', 1.5);
hold off;
title('Eroare la Heun');

