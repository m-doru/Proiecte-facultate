function [ x, L, U ] = DescLU( A, b)

n = size(A, 1);

U = zeros(size(A));
L = zeros(size(A));

U(1, :) = A(1, :);
L(:, 1) = A(:, 1)./U(1,1);

for k = 2:n
    for j = k:n
        U(k,j) = A(k,j) - sum(L(k, 1:k-1).*U(1:k-1, j)');
    end
    
    for i = k:n
        L(i,k) = 1/U(k,k)*(A(i,k) - sum(L(i, 1:k-1).*U(1:k-1, k)'));
    end
end

y = SubsAsc(L, b);
x = SubsDesc(U, y);

end

