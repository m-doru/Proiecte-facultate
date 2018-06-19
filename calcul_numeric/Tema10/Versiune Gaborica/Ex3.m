
x0 = [3; 2; 3];
[t, x] = RungeKutta(@f3, 0, 3, x0, 200);
pc = plot(t,abs(x(1,:)-f31(t)),'b');
hold on;
plot(t,abs(x(2,:)-f32(t)),'r');
plot(t,abs(x(3,:)-f33(t)),'g');
title('Eroare Runge Kutta - Ex 3');