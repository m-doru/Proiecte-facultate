function [x, N] = MetJacobiR(A, a, eps, sigma)

B = eye(size(A)) - sigma*A;
b = sigma*a;

x0 = zeros(size(a));
x1 = b;
k = 1;

while norm(x1-x0) >= eps
    x0 = x1;
    x1 = B*x0 + b;
    k = k + 1;
end

x = x1;
N = k;
end