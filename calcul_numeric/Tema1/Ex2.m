x = linspace(0, 4, 1000);

y = Fex2(x);

plot(x, y, 'b');

c1 = findSolBisect(0, 1, @Fex2, 100);
c2 = findSolBisect(1, 3.2, @Fex2, 100);
c3 = findSolBisect(3.2, 4, @Fex2, 100);
c1
c2
c3

hold on;
plot(c1, Fex2(c1), 'rx');
plot(c2, Fex2(c2), 'rx');
plot(c3, Fex2(c3), 'rx');
hold off;