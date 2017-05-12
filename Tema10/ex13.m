f = @(x, t) x - (t^2) + 1;
df = @(x, t) x - (t^2) - 2 * t - 1;
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

figure;
[t,x] = Eulermod(f, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Euler modificata');

figure;
[t,x] = TaylorII(f,df, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Taylor 2');


figure;
[t,x] = TaylorIV(f, df,df,df, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Taylor 4');


figure;
[t,x] = Heun(f, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Heun');


figure;
[t,x] = RungeKutta(f, a, b, alfa, N);
plot(t, abs(x-solf(t)),'r');
title('Eroare Metoda Runge Kutta');
