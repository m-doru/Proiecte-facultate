a = 0;
b = 3;
N = 200;
A = [1 2; 2 1];
bval = [1; 2];
alfa = [3;2];
f = @(t, x)A * x + bval;

[t,x] = RungeKutta(f, a, b, alfa, N);