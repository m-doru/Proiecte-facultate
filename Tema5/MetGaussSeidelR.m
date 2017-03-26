function [ x, N ] = MetGaussSeidelR( A, a, eps, sigma )

x0 = zeros(size(a));
x1 = zeros(size(a));
n = size(a, 1);
b = a;
for i = 1:n    
    x1(i) = (1-sigma)*x0(i) - sigma/A(i,i)*(-b(i) + ...
        sum(A(i, 1:i-1) - x0(1:i-1)') +...
        sum(A(i, i+1:n) - x0(i+1:n)'));
end

N = 1;

while norm(x1-x0) >= eps
    x0 = x1;
    x1(i) = (1-sigma)*x0(i) - sigma/A(i,i)*(-b(i) + ...
        sum(A(i,1:i-1)-x0(1:i-1)') + sum(A(i,i+1:n)-x0(i+1:n)'));
    N = N + 1;
end

x = x1;

end

