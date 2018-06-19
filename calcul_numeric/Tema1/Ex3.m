x = linspace(-3, 3, 1000);

y1 = exp(x) - 2;

y2 = cos(y1);

plot(x, y1, 'b');
hold on;
plot(x, y2, 'g');

xstar = findSolBisect(double(0.5), double(1.5), @Fex3, -1);
xstar

tmp = exp(xstar) - 2;
plot([xstar, xstar], [tmp, cos(tmp)], 'rx');

hold off;