x = linspace(0, 4, 1000);

y = Fex1(x);

plot(x, y, 'b');

c1 = findSolBisect(0, 1, @Fex1);
c2 = findSolBisect(1, 3.2, @Fex1);
c3 = findSolBisect(3.2, 4, @Fex1);

hold on;
plot(c1, Fex1(c1), 'rx');
plot(c2, Fex1(c2), 'rx');
plot(c3, Fex1(c3), 'rx');
hold off;