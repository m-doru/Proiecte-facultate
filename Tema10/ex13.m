f = @(t, x) x - (t^2) + 1;
df = @(t, x) x - (t^2) - 2 * t - 1;
% OBS: df = d2f = d3f
a = 0;
b = 2;
alfa = 0.5;
N = 10;

solf = @(t)(t+1).^2 - 1/2.*(exp(t));
figure;
[t,x] = Euler(f, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Euler');
saveas(gcf, 'Eroare_euler.jpg', 'jpg');

figure;
[t,x] = Eulermod(f, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Euler modificata');
saveas(gcf, 'eroare_euler_mod.jpg', 'jpg');

figure;
[t,x] = TaylorII(f,df, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Taylor 2');
saveas(gcf, 'eroare_Metoda_Taylor_2.jpg', 'jpg');

figure;
[t,x] = TaylorIV(f, df,df,df, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Taylor 4');
saveas(gcf, 'eroare_Metoda_Taylor_4.jpg', 'jpg');

figure;
[t,x] = Heun(f, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Heun');
saveas(gcf, 'eroare_heun.jpg', 'jpg');

figure;
[t,x] = RungeKutta(f, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Runge Kutta');
saveas(gcf, 'eroare_runge_kutta.jpg', 'jpg');