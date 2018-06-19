x = linspace(-3, 3, 1000);

y1 = exp(x) - 2;

y2 = cos(y1);

plot(x, y1, 'b');
hold on;
plot(x, y2, 'g');
hold off;

[solBis, nrStepBis] = findSolBisect(0.5, 1.5, @Fex3, -1);
[solNR, nrStepNR] = findSolNR(0.5, 1.5, @Fex3, @Fdex3, 1, 10^-5);

solBis
nrStepBis

solNR
nrStepNR