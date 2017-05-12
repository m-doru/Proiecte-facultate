f = @(x, t) x - (t^2) + 1;
df = @(x, t) x - (t^2) - 2 * t - 1;
% OBS: df = d2f = d3f
a = 0;
b = 2;
alfa = 0.5;
N = 100;

solf = @(t)(t+1).^2 - 1/2.*(exp(t));
figure;
[t,x] = Euler(f, a, b, alfa, N);
numerica = plot(t, x,'r');
set(numerica, 'linewidth', 3);  
hold on;
fixa = plot(t, solf(t),'b');
set(fixa, 'linewidth', 1.5);
hold off;
title('Metoda Euler');
legend('numerica', 'fixa');

figure;
[t,x] = Eulermod(f, a, b, alfa, N);
numerica = plot(t, x,'r');
set(numerica, 'linewidth', 3);  
hold on;
fixa = plot(t, solf(t),'b');
set(fixa, 'linewidth', 1.5);
hold off;
title('Metoda Euler modificata');
legend('numerica', 'fixa');

figure;
[t,x] = TaylorII(f,df, a, b, alfa, N);
numerica = plot(t, x,'r');
set(numerica, 'linewidth', 3);  
hold on;
fixa = plot(t, solf(t),'b');
set(fixa, 'linewidth', 1.5);
hold off;
title('Metoda Taylor 2');
legend('numerica', 'fixa');

figure;
[t,x] = TaylorIV(f, df,df,df, a, b, alfa, N);
numerica = plot(t, x,'r');
set(numerica, 'linewidth', 3);  
hold on;
fixa = plot(t, solf(t),'b');
set(fixa, 'linewidth', 1.5);
hold off;
title('Metoda Taylor 4');
legend('numerica', 'fixa');

figure;
[t,x] = Heun(f, a, b, alfa, N);
numerica = plot(t, x,'r');
set(numerica, 'linewidth', 3);  
hold on;
fixa = plot(t, solf(t),'b');
set(fixa, 'linewidth', 1.5);
hold off;
title('Metoda Heun');
legend('numerica', 'fixa');

figure;
[t,x] = RungeKutta(f, a, b, alfa, N);
numerica = plot(t, x,'r');
set(numerica, 'linewidth', 3);  
hold on;
fixa = plot(t, solf(t),'b');
set(fixa, 'linewidth', 1.5);
hold off;
title('Metoda Runge Kutta');
legend('numerica', 'fixa');