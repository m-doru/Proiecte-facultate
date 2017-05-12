
x = [3; 2];
[t, x] = Euler(@f2, 0, 3, x, 200);
size(t(2,:)')
size(x(2,:)')
plot(t(2,:),x(2,:));