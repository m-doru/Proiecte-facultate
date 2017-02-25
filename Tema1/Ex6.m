x = linspace(0, 2.5, 1000);

x = 0.5;

y = 6*x - 14
y2 = x.^3 - 7.*(x.^2) + 14 .* x - 6
plot(x, y2, 'r');
hold on;
plot(x, y, 'b');
hold off;