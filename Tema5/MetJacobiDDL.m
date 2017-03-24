function [ x1 ] = MetJacobiDDL( A, a, eps )

n = size(A, 1);
q = normamatrinf(eye(size(A)) - A);

for i = 1:n
    if abs(A(i,i)) <= sum(abs(A(i, :))) - abs(A(i,i))
        disp('Matricea nu este diagonal dominanta pe linii');
        return;
    end
end

B = zeros(size(A));

for i = 1:n
    for j = 1:n
        if i ~= j
            B(i,j) = A(i,j)/A(i,i);
        end
    end
end

b = zeros(size(a));

for i = 1:n
    b(i) = a(i) / A(i,i);
end

x0 = zeros(size(a));
x1 = b;
norma_x1x0 = norm(x1-x0);
qpow = q;

while qpow/(1-q)*norma_x1x0 > eps
    x0 = x1;
    x1 = B * x0 + b;
    qpow = qpow * q;
end


end

