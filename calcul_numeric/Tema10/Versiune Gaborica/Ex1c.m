t2 = 0:2/10:2;
x2 = (t2 + 1).^2 - 0.5*exp(1).^t2;

[t, x] = Euler(@f, 0, 2, 0.5, 10);
subplot(3,3,1);
plot(t2,abs(x-x2),'g');
title('Eroare Euler');
[t, x] = TaylorII(@f, @df, 0, 2, 0.5, 10);
subplot(3,3,2);
plot(t2,abs(x-x2),'g');
title('Eroare Taylor II');
[t, x] = TaylorIV(@f, @df, @d2f, @d3f, 0, 2, 0.5, 10);
subplot(3,3,3);
plot(t2,abs(x-x2),'g');
title('Eroare Taylor IV');
[t, x] = EulerMod(@f, 0, 2, 0.5, 10);
subplot(3,3,4);
plot(t2,abs(x-x2),'g');
title('Eroare Euler Modificat');
[t, x] = Heun(@f, 0, 2, 0.5, 10);
subplot(3,3,5);
plot(t2,abs(x-x2),'g');
title('Eroare Heun');
[t, x] = RungeKutta(@f, 0, 2, 0.5, 10);
subplot(3,3,6);
plot(t2,abs(x-x2),'g');
title('Eroare Runge Kutta');
hold off;