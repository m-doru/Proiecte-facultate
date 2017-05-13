f = @(t, x) x - (t^2) + 1;
df = @(t, x) x - (t^2) - 2 * t - 1;
% OBS: df = d2f = d3f
a = 0;
b = 2;
alfa = 0.5;
N = 10;

[t1, x1] = Euler(f, a, b, alfa, N);
disp(['t euler : ' num2str(t1); 'x euler ' num2str(x1)]);
[t2, x2] = TaylorII(f, df, a, b, alfa, N);
disp(['t taylor2 : ' num2str(t2') ;' x taylor2 ' num2str(x2')]);
[t3, x3] = TaylorIV(f, df, df, df, a, b, alfa, N);
disp(['t taylor4 : ' num2str(t3') ;' x taylor4 ' num2str(x3')]);
[t4, x4] = Eulermod(f, a, b, alfa, N);
disp(['t eulermod : ' num2str(t4) ;' x eulermod ' num2str(x4)]);
[t5, x5] = Heun(f, a, b, alfa, N);
disp(['t heun : ' num2str(t5) ;' x heun ' num2str(x5)]);
[t6, x6] = RungeKutta(f, a, b, alfa, N);
disp(['t runge kutta : ' num2str(t6) ;' x runge kutta ' num2str(x6)]);
