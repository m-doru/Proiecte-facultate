function [ x ] = SubsDesc( A, b)

n = size(A, 1);

x = zeros(n, 1);

x(n) = b(n)/A(n,n);

for k = n-1:-1:1
    x(k) = 1/A(k,k) * (b(k) - sum(A(k, k+1:end).*(x(k+1:end)')));
end

end

