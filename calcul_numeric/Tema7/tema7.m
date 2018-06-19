f = @(x)exp(2*x);
n = 6;
a = -1;
b = 1;

x = a:0.001:b;
yf = f(x);
yp = zeros(1,size(x, 2));
for i = 1:size(yp, 2)
    yp(i) = MetNDD(f, a, b, 10*(n+1), x(i));
end

err = abs(yf - yp);

plot(x, yf, '-.r*');
hold on;
plot(x, yp, '-.g*');
plot(x, err, '-.b*');
hold off;