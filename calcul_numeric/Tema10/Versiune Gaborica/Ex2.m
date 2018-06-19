
x0 = [3; 2];
[t, x] = Euler(@f2, 0, 3, x0, 200);
subplot(3,3,1);
pc = plot(t,abs(x(1,:)-f21(t)),'b');
set(pc,'linewidth', 4);
hold on;
plot(t,abs(x(2,:)-f22(t)),'r');
title('Eroare Euler');

subplot(3,3,2);
[t, x] = Midpoint(@f2, 0, 3, x0, 200);
pc = plot(t,abs(x(1,:)-f21(t)),'b');
set(pc,'linewidth', 4);
hold on;
plot(t,abs(x(2,:)-f22(t)),'r');
title('Eroare Midpoint');

subplot(3,3,3);
[t, x] = EulerMod(@f2, 0, 3, x0, 200);
pc = plot(t,abs(x(1,:)-f21(t)),'b');
set(pc,'linewidth', 4);
hold on;
plot(t,abs(x(2,:)-f22(t)),'r');
title('Eroare EulerMod');

subplot(3,3,4);
[t, x] = Heun(@f2, 0, 3, x0, 200);
pc = plot(t,abs(x(1,:)-f21(t)),'b');
set(pc,'linewidth', 4);
hold on;
plot(t,abs(x(2,:)-f22(t)),'r');
title('Eroare Heun');

subplot(3,3,5);
[t, x] = RungeKutta(@f2, 0, 3, x0, 200);
pc = plot(t,abs(x(1,:)-f21(t)),'b');
set(pc,'linewidth', 4);
hold on;
plot(t,abs(x(2,:)-f22(t)),'r');
title('Eroare Runge Kutta');